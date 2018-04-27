require 'rails_helper'

describe Game, type: :model do
  context 'relationships' do
    it { should belong_to :season }
    it { should have_many :players }
    it { should delegate_method(:league).to(:season) }
  end

  context 'validations' do
    it { should validate_presence_of :season_id }
    it { should validate_presence_of :date }
  end

  context 'methods' do
    let(:game)   { create(:game) }
    let(:season) { game.season }
    let(:admin)  { season.league.creator }

    context '#available_users' do
      subject { game.available_users }

      it 'returns an empty array' do
        create(:player, user: admin, game: game)

        expect(subject).to eq([])
      end

      it 'returns available users' do
        expect(subject).to eq([[admin.full_name, admin.id]])
      end
    end

    context '#blank_text' do
      subject { game.blank_text }

      it 'returns No players available' do
        create(:player, user: admin, game: game)

        expect(subject).to eq('No players available')
      end

      it 'returns Select a player' do
        expect(subject).to eq('Select a player')
      end
    end

    context '#finish_all_players' do
      subject { game.finish_all_players }

      it 'finishes all of the players of a specific game' do
        player_1 = create(:player, finishing_time: Time.now, game: game)
        sleep(0.5)
        player_2 = create(:player, finishing_time: Time.now, game: game)

        subject
        player_1.reload; player_2.reload
        expect(player_2.finishing_place).to eq(1)
        expect(player_1.finishing_place).to eq(2)
      end
    end

    context '#finished_players' do
      subject { game.finished_players }

      it 'returns an empty array' do
        expect(subject).to eq([])
      end

      it 'returns an array of finished players' do
        player_1, player_2 = create_list(:player, 2, game: game, finishing_time: Time.now)
        player_3 = create(:player, game: game, finishing_time: nil)

        expect(subject).to match([player_1, player_2])
        expect(subject).to_not include(player_3)
      end
    end

    context '#finished_players_count' do
      subject { game.finished_players_count }

      it 'returns 0' do
        expect(subject).to eq(0)
      end

      it 'returns 2' do
        create_list(:player, 2, game: game, finishing_time: Time.now)
        create(:player, game: game, finishing_time: nil)

        expect(subject).to eq(2)
      end
    end

    context '#formatted_date' do
      subject { game.formatted_date }

      it 'returns a formatted date' do
        expect(subject).to eq('March 26, 2018')
      end

      it 'returns another formatted date' do
        game.update(date: Date.new(2015, 5, 9))

        expect(subject).to eq('May 9, 2015')
      end
    end

    context '#number_in_order' do
      it 'returns number on games' do
        game_1, game_2 = create_list(:game, 2, season: season)

        expect(game_1.number_in_order).to eq(2)
        expect(game_2.number_in_order).to eq(3)
      end
    end

    context '#unfinish_all_players' do
      subject { game.unfinish_all_players }
      it 'unfinishes all players' do
        player_1 = create(:player, finishing_place: 1, finishing_time: Time.now, game: game)
        player_2 = create(:player, finishing_place: 2, finishing_time: Time.now, game: game)

        expect(player_1.finishing_place).to eq(1)
        expect(player_2.finishing_place).to eq(2)
        subject; player_1.reload; player_2.reload
        expect(player_1.finishing_place).to be nil
        expect(player_2.finishing_place).to be nil
      end
    end

    context '#unfinished_players' do
      subject { game.unfinished_players }

      it 'returns an empty array' do
        expect(subject).to eq([])
      end


      it 'returns an array of unfinished players' do
        player_1, player_2 = create_list(:player, 2, game: game, finishing_time: Time.now)
        player_3 = create(:player, game: game, finishing_time: nil)

        expect(subject).to match([player_3])
        expect(subject).to_not include(player_1)
        expect(subject).to_not include(player_2)
      end
    end

    context '#winner_full_name' do
      subject { game.winner_full_name }

      it 'returns the first place users full name' do
        player = create(:player, finishing_place: 1, game: game)

        expect(subject).to eq(player.user.full_name)
      end

      it 'returns the highest placed users full name' do
        player = create(:player, finishing_place: 9, game: game)

        expect(subject).to eq(player.user.full_name)
      end

      it 'returns nil' do
        expect(subject).to be nil
      end
    end

  end
end
