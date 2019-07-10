# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = JSON.parse(File.read('db/categories.json'))
categories['categories'].each do |category|
  Category.create(category)
end

mechanics = JSON.parse(File.read('db/mechanics.json'))
mechanics['mechanics'].each do |mechanic|
  Mechanic.create(mechanic)
end

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
      if idx.even?
        first_name = Faker::Name.female_first_name
      else
        first_name = Faker::Name.male_first_name
      end
      last_name = Faker::Name.last_name
      email = Faker::Internet.email("#{first_name} #{last_name}", '.')

      user =   {
        username: "user#{user_idx}",
        password: password,
        password_confirmation: password,
        first_name: first_name,
        last_name: last_name,
        email: email,
        member_since: Faker::Date.backward(90),
      }
      users << user
    end
    User.create(users)
    User.all
  end

  def create_events(number)
    titles = ['Board game night', 'No Cambio at all', 'Dragons vs. Kittens', 'Weekly Carcassonne', 
      'Snakes & Ladders', 'Secret meeting of The Tea Dragon Society', 'Bears vs. Babies', '[object Object] 🤪']
    events = []
    number.times do |idx|
      event_idx = idx + 1
      start_date_time = Faker::Time.forward(14)
      end_date_time = start_date_time + [120,180,240,300,360].sample.minutes 
      
      event = {
        organiser: User.all.sample,
        title: titles.sample,
        location: Faker::Restaurant.name + ' ,' + Faker::Address.full_address,
        start_date_time: start_date_time,
        end_date_time: end_date_time,
      }
      events << event
    end
    Event.create(events)
    Event.all
  end

  users = create_users(30)
  
  # user 3 has game 1,2,3   attend: event 1,2   bring: game 1,2 to event 1, game 3 to event 2
  # user 4 has game 1,4     attend: event 1     bring: game 1 to event 1
  
  # e1 = Event.create(organiser: users[0], title: 'Fix Event1', location: 'Fix Location1',
  #    start_date_time: Faker::Time.forward(14, :afternoon), 
  #    end_date_time: Faker::Time.between(DateTime.now + 7, DateTime.now + 7, :evening)) # attend: user 3,4
  # e2 = Event.create(organiser: users[0], title: 'Fix Event2', location: 'Fix Location2',
  #    start_date_time: Faker::Time.forward(14, :afternoon), 
  #    end_date_time: Faker::Time.between(DateTime.now + 7, DateTime.now + 7, :evening)) # attend: user 3
  # e3 = Event.create(organiser: users[1], title: 'Fix Event3', location: 'Fix Location3',
  #    start_date_time: Faker::Time.forward(14, :afternoon), 
  #    end_date_time: Faker::Time.between(DateTime.now + 7, DateTime.now + 7, :evening))
  
  events = create_events(15)
  
  # a1 = Attendance.create(attendee: User.find(3), event: events[0]) 
  # a2 = Attendance.create(attendee: User.find(4), event: events[1])
  # a3 = Attendance.create(attendee: User.find(3), event: events[2])

  def create_comment(author, commentable)
    creation_time = Faker::Time.backward(10)
    Comment.create(
      author: author,
      commentable: commentable, 
      comment_text: Faker::Movies::BackToTheFuture.quote,
      created_at: creation_time,
      updated_at: creation_time,
      )
  end

  events.each do |event|
    attendees = User.all.sample((3..10).to_a.sample)
    attendees.each do |attendee|
      Attendance.create(attendee: attendee, event: event)
      creation_time = Faker::Time.backward(10)
      create_comment(attendee, event)
    end
  end

  attendances = Attendance.all

  u4 = User.find(4)

  gp1 = Gamepiece.create(owner: u4, game: Game.find(1))
  gp2 = Gamepiece.create(owner: u4, game: Game.find(2))

  5.times do
    create_comment(u4, gp1)
    create_comment(u4, gp2)
  end


  # gp3 = Gamepiece.create(owner: User.find(3), game: Game.find(3))
  # gp4 = Gamepiece.create(owner: User.find(4), game: Game.find(1))
  # gp5 = Gamepiece.create(owner: User.find(4), game: Game.find(4))

  # eg1 = Eventgame.create(attendance: attendances[0], gamepiece: gp1)
  # eg2 = Eventgame.create(attendance: attendances[0], gamepiece: gp2)
  # eg3 = Eventgame.create(attendance: attendances[0], gamepiece: gp3)
  # eg4 = Eventgame.create(attendance: attendances[1], gamepiece: gp4)


  


end