require 'csv'

module Tickets
  class CsvStorage
    FILE_PATH = Rails.root.join('tmp', 'tickets.csv')

    def initialize(file_path: FILE_PATH)
      @file_path = file_path
    end

    def write(data)
      headers = data.keys
      values = data.values

      CSV.open(file_path, 'a', write_headers: write_headers?, headers: headers) do |csv|
        csv << values
      end
    end

    def read
      CSV.open(file_path, headers: true).map(&:to_h)
    end

    def clean
      File.delete(file_path)
    end

    private

    attr_reader :file_path

    def write_headers?
      !File.exist?(file_path)
    end
  end
end
