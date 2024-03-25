module Tickets
  class CalculateStatistics < ApplicationOperation
    Statistics = Struct.new(*Ticket::STATUSES, keyword_init: true)

    def execute
      success(statistics: Statistics.new(**statistics))
    end

    private

    def statistics
      Ticket.group(:status).count
    end
  end
end
