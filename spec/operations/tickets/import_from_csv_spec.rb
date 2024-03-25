require 'rails_helper'

RSpec.describe Tickets::ImportFromCsv do
  describe '#execute' do
    subject(:result) { operation.execute }

    let(:operation) { described_class.new(storage: storage_double) }
    let(:storage_double) { instance_double(Tickets::CsvStorage, read: data, clean: nil) }
    let(:data) do
      [
        attributes_for(:ticket).slice(:name, :email, :status, :subject, :content)
      ]
    end

    it 'creates tickets from data' do
      expect { result }.to change { Ticket.count }.by(1)
    end

    it 'cleans storage' do
      expect(storage_double).to receive(:clean)
      result
    end
  end
end
