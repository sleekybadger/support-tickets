require 'rails_helper'

RSpec.describe Tickets::CalculateStatistics do
  describe '#execute' do
    subject(:result) { described_class.new.execute }

    before do
      create_list(:ticket, 2)
      create_list(:ticket, 3, :pending)
      create_list(:ticket, 2, :resolved)
    end

    it { is_expected.to be_success }

    it 'groups tickets by status and counts results' do
      expect(result.statistics.new).to eq(2)
      expect(result.statistics.pending).to eq(3)
      expect(result.statistics.resolved).to eq(2)
    end
  end
end
