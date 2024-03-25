require 'rails_helper'

RSpec.describe Tickets::StoreToCsv do
  describe '#execute' do
    subject(:result) { operation.execute(params: params) }

    let(:operation) { described_class.new(storage: storage_double) }
    let(:storage_double) { instance_double(Tickets::CsvStorage, write: nil) }

    context 'when params are valid' do
      let(:params) { attributes_for(:ticket) }

      it { is_expected.to be_success }

      it 'writes data to storage' do
        expect(storage_double).to receive(:write)
        result
      end
    end

    context 'when params are invalid' do
      let(:params) { attributes_for(:ticket, subject: nil) }

      it { is_expected.not_to be_success }
    end
  end
end
