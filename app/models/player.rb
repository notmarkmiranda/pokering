class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user
  delegate :season, to: :game

  validates :game_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :game_id }

  delegate :full_name, to: :user, prefix: true, allow_nil: true
  delegate :finished_players_count, :buy_in, to: :game, prefix: true, allow_nil: true

  def calculate_score(place=nil)
    place = finishing_place if place.nil?
    numerator = game_finished_players_count * game_buy_in ** 2 / total_expense
    denominator = place + 1
    ((Math.sqrt(numerator) / denominator) * 100).floor / 100.0
  end

  def finished_at
    finishing_time.strftime('%I:%M %P on %B %-e, %Y')
  end

  def score_and_destroy
    destroy
    game.finish_all_players
  end

  def score_and_update(time=nil)
    update(finishing_time: time)
    game.finish_all_players
  end

  private

  def total_expense
    game_buy_in + additional_expense
  end
end
