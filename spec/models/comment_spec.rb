require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:ticket) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:content) }
  end
end
