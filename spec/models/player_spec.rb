require 'rails_helper'

describe Player, type: :model do
  context 'relationships' do
    it { should belong_to :game }
    it { should belong_to :user }
    it { should delegate_method(:season).to(:game) }
  end

  context 'validations' do
    it { should validate_presence_of :game_id }
    it { should validate_presence_of :user_id }
    it do
      user = create(:user, email: 'asdf@gmail.com')
      create(:player, user: user)

      should validate_uniqueness_of(:user_id).scoped_to(:game_id)
    end
  end

  context 'methods' do
    let(:player) { create(:player, finishing_time: Time.now) }
    let(:game)   { player.game }
    let(:player_2) { create(:player, game: game, score: nil, finishing_time: Time.now) }

    context '#calculate_score' do
      subject { player.calculate_score }

      it 'returns the score for 1 player' do
        expect(subject).to eq(5.0)
      end

      it 'returns the score for 2 players' do
        create(:player, finishing_time: Time.now, game: game)

        expect(subject).to eq(7.07)
      end
    end

    context '#finished_at' do
      subject { player.finished_at }

      it 'returns a formatted time and date stamp' do
        travel_to Time.new(2015, 5, 9, 17, 30, 0) do
          expect(subject).to eq('05:30 pm on May 9, 2015')
        end
      end
    end

    context '#score_and_destroy' do
      subject { player.score_and_destroy }

      it 'destroys and scores other players' do
        expect(player_2.score).to be nil
        expect(subject).to match([player_2])
        expect(player_2.reload.score).to eq(5.0)
      end
    end

    context '#score_and_update' do
      subject { player_2.score_and_update(Time.now); player_2.reload; player_2.score }

      it 'finishes all of the players' do
        expect(player_2.score).to be nil
        expect(subject).to eq(7.07)
      end
    end

    context 'self#rank_by_score' do
      subject { Player.rank_by_score(game.season) }

      it 'returns players in ranked order' do
        player; player_2

        players = subject
        expect(players.first.user_id).to eq(player_2.user_id)
        expect(players.last.user_id).to eq(player.user_id)
      end
    end

  end
end
