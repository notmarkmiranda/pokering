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

  context 'methods' do
    context '#number_in_order' do
      let(:season) { create(:season) }
      it 'returns number on games' do
        game_1, game_2 = create_list(:game, 2, season: season)

        expect(game_1.number_in_order).to eq(1)
        expect(game_2.number_in_order).to eq(2)
      end
    end
  end
end
