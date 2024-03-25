module Tickets
  class ImportFromCsv < ApplicationOperation
    def initialize(storage: CsvStorage.new)
      @storage = storage
    end

    def execute
      result = Ticket.insert_all!(storage.read).tap do
        storage.clean
      end

      success(count: result.count)
    end

    private

    attr_reader :storage
  end
end
