class League < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :permissions, -> { where(subject_class: 'League') }, foreign_key: :subject_id, dependent: :destroy
  has_many :seasons, dependent: :destroy
	has_many :games, through: :seasons
  has_many :players, through: :games

  delegate :permissions, to: :creator, prefix: true, allow_nil: false
  delegate :full_name, to: :creator, prefix: true, allow_nil: false

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true

  after_create_commit :create_permission, :create_initial_season

  def active_season
    seasons.where(active: true).first
  end

  def active_season_standings(season=nil)
    season = season || active_season || Season.last
    season.players_rankings
  end

  private

  def create_initial_season
    self.seasons.create(active: true, completed: false)
  end

  def create_permission
    creator_permissions.create!(subject_id: self.id, subject_class: self.class.to_s, action: 'manage')
  end
end
