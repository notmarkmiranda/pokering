class Game < ApplicationRecord
  belongs_to :season
  delegate :league, to: :season

  validates :season_id, presence: true
  validates :date, presence: true

  scope :reverse_chronological, -> { order(date: :desc) }
  scope :chronological, -> { order(date: :asc) }

  def number_in_order
    (league.games.chronological.index(self) + 1).to_i
  end
end
