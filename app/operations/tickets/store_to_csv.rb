module Tickets
  class StoreToCsv < ApplicationOperation
    def initialize(storage: CsvStorage.new)
      @storage = storage
    end

    def execute(params:)
      ticket = Ticket.new(params)
      return failure(ticket: ticket) unless ticket.valid?

      storage.write(ticket.attributes.compact)

      success
    end

    private

    attr_reader :storage
  end
end
