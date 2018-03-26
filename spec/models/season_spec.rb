require 'rails_helper'

RSpec.describe Season, type: :model do
  context 'relationships' do
    it { should belong_to :league }
  end

  context 'validations' do
    it { should validate_presence_of :league_id }
  end

  context 'methods' do
    let(:season) { create(:season) }

    context 'active / complete methods' do
      it 'active & complete = true' do
        season.update(active: true, completed: true)

        expect(season.activate_button('active')).to eq('times-circle')
        expect(season.activate_button('completed')).to eq('times-circle')
        expect(season.active_text).to eq('Active')
        expect(season.active_title).to eq('Mark as Inactive')
        expect(season.completed_text).to eq('Completed')
        expect(season.completed_title).to eq('Mark as Incomplete')
      end

      it 'active & complete = false' do
        season.update(active: false, completed: false)

        expect(season.activate_button('active')).to eq('check-circle')
        expect(season.activate_button('completed')).to eq('check-circle')
        expect(season.active_text).to eq('Inactive')
        expect(season.active_title).to eq('Mark as Active')
        expect(season.completed_text).to eq('Incomplete')
        expect(season.completed_title).to eq('Mark as Complete')
      end
    end
  end
end
