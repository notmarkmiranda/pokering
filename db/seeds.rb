# USERS
m_miranda     = User.create(email: 'markmiranda51@gmail.com', password: 'password', first_name: 'Mark', last_name: 'Miranda')
m_cassano     = User.create(email: 'mcassano@gmail.com', password: SecureRandom.hex(24), first_name: 'Michael', last_name: 'Cassano')
s_lyndon      = User.create(email: 'mail@shawnlyndon.com', password: SecureRandom.hex(24), first_name: 'Shawn', last_name: 'Lyndon')
a_baum        = User.create(email: 'a.n.baum@gmail.com', password: SecureRandom.hex(24), first_name: 'Tight Andy', last_name: 'Baum')
t_merry       = User.create(email: 'tymerry@gmail.com', password: SecureRandom.hex(24), first_name: 'Tyler', last_name: 'Merry')
c_kampe       = User.create(email: 'christopher.kampe@gmail.com', password: SecureRandom.hex(24), first_name: 'Chris', last_name: 'Kampe')
z_moore       = User.create(email: 'zacharymichaelmoore@gmail.com', password: SecureRandom.hex(24), first_name: 'Zachary', last_name: 'Moore')
j_mann        = User.create(email: 'jonathanmann123@gmail.com', password: SecureRandom.hex(24), first_name: 'Jonathan', last_name: 'Mann')
m_green       = User.create(email: 'nekbet@gmail.com', password: SecureRandom.hex(24), first_name: 'Mike', last_name: 'Green')
e_starling    = User.create(email: 'plasticsun@gmail.com', password: SecureRandom.hex(24), first_name: 'Eric', last_name: 'Starling')
j_mortenson   = User.create(email: 'jessemortenson@gmail.com', password: SecureRandom.hex(24), first_name: 'Jesse', last_name: 'Mortenson')
s_lukes       = User.create(email: 'scott@echo-summit.com', password: SecureRandom.hex(24), first_name: 'Scott', last_name: 'Lukes')
j_bogdan      = User.create(email: 'jzb@hotmail.com', password: SecureRandom.hex(24), first_name: 'Julius', last_name: 'Bogdan')
m_harris      = User.create(email: 'm.harris74@comcast.net', password: SecureRandom.hex(24), first_name: 'Mark', last_name: 'Harris')
j_balu        = User.create(email: 'jeremy.balu@gmail.com', password: SecureRandom.hex(24), first_name: 'Jeremy', last_name: 'Balu')
a_schindler   = User.create(email: 'adschindler@gmail.com', password: SecureRandom.hex(24), first_name: 'Alan', last_name: 'Schindler')
a_fullerton   = User.create(email: 'andrew.fullerton@gmail.com', password: SecureRandom.hex(24), first_name: 'Andrew', last_name: 'Fullerton')
b_iverson     = User.create(email: 'bjorn_iverson@markmiranda.ninja', password: SecureRandom.hex(24), first_name: 'Bjorn', last_name: 'Iverson')
e_austin      = User.create(email: 'eric_austin@markmiranda.ninja', password: SecureRandom.hex(24), first_name: 'Eric', last_name: 'Austin')
z_other       = User.create(email: 'zach_other@markmiranda.ninja', password: SecureRandom.hex(24), first_name: 'Zach', last_name: 'Other')
k_wheeler     = User.create(email: 'kyle.wheeler@gmail.com', password: SecureRandom.hex(24), first_name: 'Kyle', last_name: 'Wheeler')
e_gehringer   = User.create(email: 'gehringer.eric@gmail.com', password: SecureRandom.hex(24), first_name: 'Eric', last_name: 'Gehringer')
m_bloom       = User.create(email: 'matt_bloom@markmiranda.ninja', password: SecureRandom.hex(24), first_name: 'Matt', last_name: 'Bloom')
m_houston     = User.create(email: 'marshall.houston@gmail.com', password: SecureRandom.hex(24), first_name: 'Marshall', last_name: 'Houston')
j_mortenson   = User.create(email: 'jessemortenson@gmail.com', password: SecureRandom.hex(24), first_name: 'Jesse', last_name: 'Mortenson')
b_nichols     = User.create(email: 'banichols@gmail.com', password: SecureRandom.hex(24), first_name: 'Brent', last_name: 'Nichols')
b_zanti       = User.create(email: 'brianzanti@gmail.com', password: SecureRandom.hex(24), first_name: 'Brian', last_name: 'Zanti')
m_milton      = User.create(email: 'matt.milton@gmail.com', password: SecureRandom.hex(24), first_name: 'Matt', last_name: 'Milton')
h_svishneuski = User.create(email: 'svishneuski@squaretrade.com', password: SecureRandom.hex(24), first_name: 'Matt', last_name: 'Milton')

league = League.create(name: "Mike Cassano's Super Fun League", user_id: m_miranda.id)
first_season = league.seasons.first

# PERMISSIONS
m_miranda.permissions.create(subject_class: 'League', subject_id: league.id, action: 'manage')
User.where.not(id: m_miranda).each do |user|
  user.permissions.create(subject_class: 'League', subject_id: league.id, action: 'read')
end

g_20151105 = first_season.games.create(date: Date.new(2015, 11, 05), completed: true, buy_in: 15)
Player.create(game_id: g_20151105.id, user_id: m_miranda.id, finishing_time: Time.now)
Player.create(game_id: g_20151105.id, user_id: s_lyndon.id, finishing_time: Time.now)
Player.create(game_id: g_20151105.id, user_id: m_cassano.id, finishing_time: Time.now)
g_20151105.finish_all_players

g_20151207 = first_season.games.create(date: Date.new(2015, 12, 07), completed: true, buy_in: 15)
Player.create(game_id: g_20151207.id, user_id: a_baum.id, finishing_time: Time.now)
Player.create(game_id: g_20151207.id, user_id: t_merry.id, finishing_time: Time.now)
Player.create(game_id: g_20151207.id, user_id: m_miranda.id, finishing_time: Time.now)
g_20151207.finish_all_players

g_20160105 = first_season.games.create(date: Date.new(2016, 1, 5), completed: true, buy_in: 15)
Player.create(game_id: g_20160105.id, user_id: c_kampe.id, finishing_time: Time.now)
Player.create(game_id: g_20160105.id, user_id: m_miranda.id, finishing_time: Time.now)
Player.create(game_id: g_20160105.id, user_id: a_baum.id, finishing_time: Time.now)
g_20160105.finish_all_players

g_20160215 = first_season.games.create(date: Date.new(2016, 2, 15), completed: true, buy_in: 15)
Player.create(game_id: g_20160215.id, user_id: z_moore.id, finishing_time: Time.now)
Player.create(game_id: g_20160215.id, user_id: m_miranda.id, finishing_time: Time.now)
Player.create(game_id: g_20160215.id, user_id: s_lyndon.id, finishing_time: Time.now)
g_20160215.finish_all_players

g_20160315 = first_season.games.create(date: Date.new(2016, 3, 15), completed: true, buy_in: 15)
Player.create(game_id: g_20160315.id, user_id: a_baum.id, finishing_time: Time.now)
Player.create(game_id: g_20160315.id, user_id: s_lyndon.id, finishing_time: Time.now)
Player.create(game_id: g_20160315.id, user_id: m_cassano.id, finishing_time: Time.now)
g_20160315.finish_all_players

g_20160405 = first_season.games.create(date: Date.new(2016, 4, 5), completed: true, buy_in: 15)
Player.create(game_id: g_20160405.id, user_id: s_lyndon.id, finishing_time: Time.now)
Player.create(game_id: g_20160405.id, user_id: j_mann.id, finishing_time: Time.now)
Player.create(game_id: g_20160405.id, user_id: a_baum.id, finishing_time: Time.now)
g_20160405.finish_all_players

g_20160511 = first_season.games.create(date: Date.new(2016, 5, 11), completed: true, buy_in: 15)
Player.create(game_id: g_20160511.id, user_id: m_green.id, finishing_time: Time.now)
Player.create(game_id: g_20160511.id, user_id: e_starling.id, finishing_time: Time.now)
Player.create(game_id: g_20160511.id, user_id: c_kampe.id, finishing_time: Time.now)
g_20160511.finish_all_players

g_20160613 = first_season.games.create(date: Date.new(2016, 6, 13), completed: true, buy_in: 15)
Player.create(game_id: g_20160613.id, user_id: c_kampe.id, finishing_time: Time.now)
Player.create(game_id: g_20160613.id, user_id: m_cassano.id, finishing_time: Time.now)
Player.create(game_id: g_20160613.id, user_id: t_merry.id, finishing_time: Time.now)
g_20160613.finish_all_players

g_20160713 = first_season.games.create(date: Date.new(2016, 7, 13), completed: true, buy_in: 15)
Player.create(game_id: g_20160713.id, user_id: j_mortenson.id, finishing_time: Time.now)
Player.create(game_id: g_20160713.id, user_id: t_merry.id, finishing_time: Time.now)
Player.create(game_id: g_20160713.id, user_id: m_cassano.id, finishing_time: Time.now)
g_20160713.finish_all_players

g_20160816 = first_season.games.create(date: Date.new(2016, 8, 16), completed: true, buy_in: 15)
Player.create(game_id: g_20160816.id, user_id: m_green.id, finishing_time: Time.now)
Player.create(game_id: g_20160816.id, user_id: a_baum.id, finishing_time: Time.now)
Player.create(game_id: g_20160816.id, user_id: c_kampe.id, finishing_time: Time.now)
g_20160816.finish_all_players

g_20160921 = first_season.games.create(date: Date.new(2016, 9, 21), completed: true, buy_in: 15)
Player.create(game_id: g_20160921.id, user_id: c_kampe.id, finishing_time: Time.now)
Player.create(game_id: g_20160921.id, user_id: m_miranda.id, finishing_time: Time.now)
Player.create(game_id: g_20160921.id, user_id: m_cassano.id, finishing_time: Time.now)
g_20160921.finish_all_players

g_20161018 = first_season.games.create(date: Date.new(2016, 10, 18), completed: true, buy_in: 15)
Player.create(game_id: g_20161018.id, user_id: m_miranda.id, finishing_time: Time.now)
Player.create(game_id: g_20161018.id, user_id: m_cassano.id, finishing_time: Time.now)
Player.create(game_id: g_20161018.id, user_id: t_merry.id, finishing_time: Time.now)
g_20161018.finish_all_players

first_season.update(completed: true, active: false)

second_season = league.seasons.create!

g_20161115 = second_season.games.create(date: Date.new(2016, 11, 15), completed: true, buy_in: 15)
g_20161115.players.create(user_id: s_lukes.id, finishing_time: Time.now)
g_20161115.players.create(user_id: j_bogdan.id, finishing_time: Time.now)
g_20161115.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20161115.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20161115.players.create(user_id: m_harris.id, finishing_time: Time.now)
g_20161115.players.create(user_id: m_cassano.id, finishing_time: Time.now, additional_expense: 15)
g_20161115.players.create(user_id: j_mann.id, finishing_time: Time.now)
g_20161115.players.create(user_id: j_balu.id, finishing_time: Time.now)
g_20161115.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20161115.finish_all_players

g_20161212 = second_season.games.create(date: Date.new(2016, 12, 12), completed: true, buy_in: 15)
g_20161212.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20161212.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20161212.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20161212.players.create(user_id: c_kampe.id, finishing_time: Time.now)
g_20161212.players.create(user_id: s_lukes.id, finishing_time: Time.now)
g_20161212.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20161212.players.create(user_id: a_schindler.id, finishing_time: Time.now, additional_expense: 15)
g_20161212.players.create(user_id: j_mann.id, finishing_time: Time.now)
g_20161212.players.create(user_id: j_balu.id, finishing_time: Time.now)
g_20161212.finish_all_players

g_20170116 = second_season.games.create(date: Date.new(2017, 1, 16), completed: true, buy_in: 15)
g_20170116.players.create(user_id: j_balu.id, finishing_time: Time.now)
g_20170116.players.create(user_id: a_fullerton.id, finishing_time: Time.now)
g_20170116.players.create(user_id: s_lukes.id, finishing_time: Time.now)
g_20170116.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20170116.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20170116.players.create(user_id: c_kampe.id, finishing_time: Time.now)
g_20170116.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20170116.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20170116.finish_all_players

g_20170220 = second_season.games.create(date: Date.new(2017, 2, 20), completed: true, buy_in: 15)
g_20170220.players.create(user_id: a_fullerton.id, finishing_time: Time.now)
g_20170220.players.create(user_id: b_iverson.id, finishing_time: Time.now, additional_expense: 15)
g_20170220.players.create(user_id: c_kampe.id, finishing_time: Time.now)
g_20170220.players.create(user_id: j_mann.id, finishing_time: Time.now)
g_20170220.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20170220.players.create(user_id: e_austin.id, finishing_time: Time.now)
g_20170220.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20170220.players.create(user_id: a_schindler.id, finishing_time: Time.now)
g_20170220.players.create(user_id: m_green.id, finishing_time: Time.now)
g_20170220.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20170220.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20170220.finish_all_players

g_20170321 = second_season.games.create(date: Date.new(2017, 3, 21), completed: true, buy_in: 15)
g_20170321.players.create(user_id: j_balu.id, finishing_time: Time.now)
g_20170321.players.create(user_id: j_mann.id, finishing_time: Time.now)
g_20170321.players.create(user_id: z_other.id, finishing_time: Time.now, additional_expense: 15)
g_20170321.players.create(user_id: m_green.id, finishing_time: Time.now)
g_20170321.players.create(user_id: c_kampe.id, finishing_time: Time.now)
g_20170321.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20170321.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20170321.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20170321.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20170321.finish_all_players

g_20170418 = second_season.games.create(date: Date.new(2017, 4, 18), completed: true, buy_in: 15)
g_20170418.players.create(user_id: j_balu.id, finishing_time: Time.now, additional_expense: 15)
g_20170418.players.create(user_id: s_lukes.id, finishing_time: Time.now)
g_20170418.players.create(user_id: m_harris.id, finishing_time: Time.now)
g_20170418.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20170418.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20170418.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20170418.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20170418.players.create(user_id: c_kampe.id, finishing_time: Time.now)
g_20170418.finish_all_players

g_20170523 = second_season.games.create(date: Date.new(2017, 5, 23), completed: true, buy_in: 15)
g_20170523.players.create(user_id: s_lukes.id, finishing_time: Time.now)
g_20170523.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20170523.players.create(user_id: j_mann.id, finishing_time: Time.now)
g_20170523.players.create(user_id: j_balu.id, finishing_time: Time.now)
g_20170523.players.create(user_id: c_kampe.id, finishing_time: Time.now)
g_20170523.players.create(user_id: m_cassano.id, finishing_time: Time.now, additional_expense: 15)
g_20170523.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20170523.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20170523.finish_all_players

g_20170725 = second_season.games.create(date: Date.new(2017, 7, 25), completed: true, buy_in: 15)
g_20170725.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20170725.players.create(user_id: m_green.id, finishing_time: Time.now)
g_20170725.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20170725.players.create(user_id: j_mann.id, finishing_time: Time.now)
g_20170725.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20170725.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20170725.players.create(user_id: j_balu.id, finishing_time: Time.now)
g_20170725.finish_all_players

g_20170822 = second_season.games.create(date: Date.new(2017, 8, 22), completed: true, buy_in: 15)
g_20170822.players.create(user_id: j_mann.id, finishing_time: Time.now)
g_20170822.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20170822.players.create(user_id: a_fullerton.id, finishing_time: Time.now)
g_20170822.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20170822.players.create(user_id: s_lukes.id, finishing_time: Time.now)
g_20170822.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20170822.players.create(user_id: s_lyndon.id, finishing_time: Time.now)
g_20170822.players.create(user_id: k_wheeler.id, finishing_time: Time.now, additional_expense: 15)
g_20170822.finish_all_players


g_20170912 = second_season.games.create(date: Date.new(2017, 9, 12), completed: true, buy_in: 15)
g_20170912.players.create(user_id: m_green.id, finishing_time: Time.now)
g_20170912.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20170912.players.create(user_id: c_kampe.id, finishing_time: Time.now)
g_20170912.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20170912.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20170912.players.create(user_id: k_wheeler.id, finishing_time: Time.now)
g_20170912.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20170912.finish_all_players

g_20171017 = second_season.games.create(date: Date.new(2017, 10, 17), completed: true, buy_in: 15)
g_20171017.players.create(user_id: s_lukes.id, finishing_time: Time.now)
g_20171017.players.create(user_id: e_gehringer.id, finishing_time: Time.now)
g_20171017.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20171017.players.create(user_id: c_kampe.id, finishing_time: Time.now)
g_20171017.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20171017.players.create(user_id: a_fullerton.id, finishing_time: Time.now)
g_20171017.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20171017.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20171017.players.create(user_id: m_bloom.id, finishing_time: Time.now)
g_20171017.players.create(user_id: j_mann.id, finishing_time: Time.now)
g_20171017.players.create(user_id: a_schindler.id, finishing_time: Time.now)
g_20171017.finish_all_players

g_20171115 = second_season.games.create(date: Date.new(2017, 11, 15), completed: true, buy_in: 15)
g_20171115.players.create(user_id: c_kampe.id, finishing_time: Time.now)
g_20171115.players.create(user_id: m_green.id, finishing_time: Time.now)
g_20171115.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20171115.players.create(user_id: a_fullerton.id, finishing_time: Time.now)
g_20171115.players.create(user_id: m_houston.id, finishing_time: Time.now)
g_20171115.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20171115.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20171115.players.create(user_id: e_gehringer.id, finishing_time: Time.now)
g_20171115.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20171115.finish_all_players

second_season.update(completed: true, active: false)

third_season = league.seasons.create!

g_20171216 = third_season.games.create(date: Date.new(2017, 12, 16), completed: true, buy_in: 15)
g_20171216.players.create(user_id: j_mortenson.id, finishing_time: Time.now)
g_20171216.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20171216.players.create(user_id: b_nichols.id, finishing_time: Time.now)
g_20171216.players.create(user_id: k_wheeler.id, finishing_time: Time.now)
g_20171216.players.create(user_id: b_zanti.id, finishing_time: Time.now)
g_20171216.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20171216.players.create(user_id: m_green.id, finishing_time: Time.now)
g_20171216.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20171216.finish_all_players

g_20180215 = third_season.games.create(date: Date.new(2018, 2, 15), completed: true, buy_in: 15)
g_20180215.players.create(user_id: m_milton.id, finishing_time: Time.now)
g_20180215.players.create(user_id: j_balu.id, finishing_time: Time.now)
g_20180215.players.create(user_id: m_cassano.id, finishing_time: Time.now, additional_expense: 15)
g_20180215.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20180215.players.create(user_id: m_houston.id, finishing_time: Time.now)
g_20180215.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20180215.players.create(user_id: j_mann.id, finishing_time: Time.now)
g_20180215.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20180215.finish_all_players

g_20180315 = third_season.games.create(date: Date.new(2018, 3, 15), completed: true, buy_in: 15)
g_20180315.players.create(user_id: m_miranda.id, finishing_time: Time.now)
g_20180315.players.create(user_id: s_lukes.id, finishing_time: Time.now)
g_20180315.players.create(user_id: j_mann.id, finishing_time: Time.now)
g_20180315.players.create(user_id: a_baum.id, finishing_time: Time.now)
g_20180315.players.create(user_id: m_cassano.id, finishing_time: Time.now)
g_20180315.players.create(user_id: m_green.id, finishing_time: Time.now)
g_20180315.players.create(user_id: h_svishneuski.id, finishing_time: Time.now)
g_20180315.players.create(user_id: t_merry.id, finishing_time: Time.now)
g_20180315.players.create(user_id: k_wheeler.id, finishing_time: Time.now, additional_expense: 15)
g_20180315.finish_all_players
