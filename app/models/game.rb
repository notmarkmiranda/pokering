class Game < ApplicationRecord
  belongs_to :season
  has_many :players
  delegate :league, to: :season

  validates :season_id, presence: true
  validates :date, presence: true

  scope :reverse_chronological, -> { order(date: :desc) }
  scope :chronological, -> { order(date: :asc) }

  def available_users
    users = User.joins(:permissions).where(permissions: { subject_class: 'League', subject_id: league.id }).sort_by(&:full_name) - players.map(&:user)
    users.collect { |user| [user.full_name, user.id] }
  end

  def blank_text
    available_users.empty? ? 'No players available' : 'Select a player'
  end

  def finish_all_players
    ordered_players = players.where.not(finishing_time: nil).order(finishing_time: :desc)
    ordered_players.each_with_index do |player, index|
      place = (index + 1).to_i
      player.update(finishing_place: place, score: player.calculate_score(place))
    end
  end

  def finished_players
    players.where.not(finishing_time: nil, id: nil).order(finishing_time: :desc)
  end

  def finished_players_count
    finished_players.count
  end

  def formatted_date
    date.strftime('%B %-e, %Y')
  end

  def number_in_order
    (league.games.chronological.index(self) + 1).to_i
  end

  def unfinish_all_players
    players.update_all(finishing_place: nil, score: nil)
  end

  def unfinished_players
    players.where(finishing_time: nil).where.not(id: nil)
  end

  def winner_full_name
    winner&.full_name
  end

  private

  def winner
    players.min_by(&:finishing_place)&.user
  end
end
