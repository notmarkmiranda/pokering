require 'rails_helper'

describe Game, type: :model do
  context 'relationships' do
    it { should belong_to :season }
    it { should delegate_method(:league).to(:season) }
  end

  context 'validations' do
    it { should validate_presence_of :season_id }
    it { should validate_presence_of :date }
  end

  context 'methods'
end
