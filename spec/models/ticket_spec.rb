require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:comments) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to allow_value('hello@example.com').for(:email) }
    it { is_expected.not_to allow_value('example.com').for(:email) }
  end

  describe 'State Machine' do
    subject(:ticket) { create(:ticket) }

    it 'sets default status to new' do
      expect(ticket.status).to eq('new')
    end

    describe '#start' do
      it 'changes status from new to pending' do
        expect { ticket.start }.to change { ticket.status }.from('new').to('pending')
      end
    end

    describe '#resolve' do
      context 'when ticket has comments' do
        let!(:comment) { create(:comment, ticket: ticket) }

        it 'changes status to resolved' do
          expect { ticket.resolve }.to change { ticket.status }.from('new').to('resolved')
        end
      end

      context 'when ticket without comments' do
        it 'raises error' do
          expect { ticket.resolve }.to raise_error(AASM::InvalidTransition)
        end
      end
    end
  end
end
