require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'attributes' do
    it { should validate_presence_of(:content) }
  end

  describe 'relationships' do
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
  end
end
