# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


unless Rails.env.production?
  # Seed with games ["3xbCLNpbny", "fDn9rQjH9O", "GP7Y2xOUzj", "74f9mzbw9Y"]
  connection = ActiveRecord::Base.connection
  sql = File.read('db/games.sql')
  statements = sql.split(/;$/)
  statements.pop

  ActiveRecord::Base.transaction do
    statements.each do |statement|
      connection.execute(statement)
    end
  end


  def create_users(number)
    users = []
    number.times do |idx|
      user_idx = idx + 1
      password = "#{user_idx}" * 6
      user =   {
        username: "user#{user_idx}",
        password: password,
        password_confirmation: password,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        member_since: Faker::Date.backward(90)
      }
      users << user
    end
    User.create(users)
  end

  create_users(5)

  # user 3 has game 1,2,3   attend: event 1,2   bring: game 1,2 to event 1, game 3 to event 2
  # user 4 has game 1,4     attend: event 1     bring: game 1 to event 1

  e1 = Event.create(organiser: User.first, title: 'Event1') # attend: user 3,4
  e2 = Event.create(organiser: User.first, title: 'Event2') # attend: user 3
  e3 = Event.create(organiser: User.second, title: 'Event3')

  a1 = Attendance.create(attendee: User.find(3), event: e1) 
  a2 = Attendance.create(attendee: User.find(4), event: e1)
  a3 = Attendance.create(attendee: User.find(3), event: e2)

  gp1 = Gamepiece.create(owner: User.find(3), game: Game.find(1))
  gp2 = Gamepiece.create(owner: User.find(3), game: Game.find(2))
  gp3 = Gamepiece.create(owner: User.find(3), game: Game.find(3))
  gp4 = Gamepiece.create(owner: User.find(4), game: Game.find(1))
  gp5 = Gamepiece.create(owner: User.find(4), game: Game.find(4))

  eg1 = Eventgame.create(attendance: a1, gamepiece: gp1)
  eg2 = Eventgame.create(attendance: a1, gamepiece: gp2)
  eg3 = Eventgame.create(attendance: a1, gamepiece: gp3)
  eg4 = Eventgame.create(attendance: a2, gamepiece: gp4)

end