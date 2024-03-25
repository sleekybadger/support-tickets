require 'rails_helper'

RSpec.describe Tickets::Search do
  describe '#execute' do
    subject(:result) { described_class.new.execute(params: params) }

    let!(:new_ticket) { create(:ticket) }
    let!(:resolved_ticket) { create(:ticket, :resolved) }

    context 'when params are empty' do
      let(:params) { {} }

      it { is_expected.to be_success }

      it 'returns all tickets' do
        expect(result.tickets).to eq([new_ticket, resolved_ticket])
      end
    end

    context 'when params include status' do
      let(:params) { Hash[:status, 'new'] }

      it { is_expected.to be_success }

      it 'returns tickets with matched status' do
        expect(result.tickets).to eq([new_ticket])
      end
    end

    context 'when params include query' do
      let(:params) { Hash[:query, 'qwerty'] }

      context 'when ticket name matches query' do
        let!(:ticket) { create(:ticket, name: 'qwerty') }

        it { is_expected.to be_success }

        it 'returns tickets with matched name' do
          expect(result.tickets).to eq([ticket])
        end
      end

      context 'when ticket email matches query' do
        let!(:ticket) { create(:ticket, email: 'qwerty@example.com') }

        it { is_expected.to be_success }

        it 'returns tickets with matched email' do
          expect(result.tickets).to eq([ticket])
        end
      end

      context 'when ticket subject matches query' do
        let!(:ticket) { create(:ticket, subject: 'qwerty') }

        it { is_expected.to be_success }

        it 'returns tickets with matched subject' do
          expect(result.tickets).to eq([ticket])
        end
      end
    end
  end
end
