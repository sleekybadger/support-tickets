module Tickets
  class Search < ApplicationOperation
    def execute(params:)
      query = params[:query].presence
      status = params[:status].presence

      scope = Ticket.includes(:comments)
      scope = filter_by_status(scope, status)
      scope = filter_by_query(scope, query)

      success(tickets: scope, query: query, status: status)
    end

    private

    def filter_by_status(scope, status)
      return scope unless status

      scope.where(status: status)
    end

    def filter_by_query(scope, query)
      return scope unless query

      pattern = "%#{query}%"

      scope
        .where('name ILIKE ?', pattern)
        .or(scope.where("email ILIKE ?", pattern))
        .or(scope.where("subject ILIKE ?", pattern))
    end
  end
end
