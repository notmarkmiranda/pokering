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

  def self.rank_by_score(season=nil)
    @active_season = season || Season.last
    @season_users = select(:user_id).distinct.pluck(:user_id)
    return if @season_users.empty?

    find_by_sql(query)
  end

  private

  def self.query
    "SELECT user_id, SUM(score) AS cumulative_score, COUNT(game_id) \
     AS games_count FROM (#{subquery}) AS c_players GROUP BY \
     c_players.user_id ORDER BY cumulative_score DESC"
  end

  def self.subquery
    # TODO: (2018-04-26) markmiranda => LIMIT 9 needs to change to a season setting
    @season_users.map do |user_id|
      "(SELECT players.* FROM players INNER JOIN games ON \
       players.game_id = games.id WHERE user_id = #{user_id} AND \
       games.season_id = #{@active_season.id} ORDER BY score LIMIT 9)"
    end.join("\nUNION ALL\n")
  end

  def total_expense
    game_buy_in + additional_expense
  end
end
