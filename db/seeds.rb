# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

games_json = JSON.parse(File.read('db/games.json'))
games_json.each do |game|
  Game.create(game)
end
games = Game.all

categories_json = JSON.parse(File.read('db/categories.json'))
categories_json['categories'].each do |category|
  Category.create(category)
end

mechanics_json = JSON.parse(File.read('db/mechanics.json'))
mechanics_json['mechanics'].each do |mechanic|
  Mechanic.create(mechanic)
end

# unless Rails.env.production?
  # Seed with games ["3xbCLNpbny", "fDn9rQjH9O", "GP7Y2xOUzj", "74f9mzbw9Y"]
  # connection = ActiveRecord::Base.connection
  # sql = File.read('db/games.sql')
  # statements = sql.split(/;$/)
  # statements.pop

  # ActiveRecord::Base.transaction do
  #   statements.each do |statement|
  #     connection.execute(statement)
  #   end
  # end

  def create_users(number)
    users = []
    number.times do |idx|
      user_idx = idx + 1
      password = '123456'
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
    titles = ['Board game night', 'Anything but Cambio', 'Dragons and Kittens',
       'Weekly Carcassonne', 'Snakes & Ladders', 'Secret meeting of The Tea Dragon Society', 
       'Bears vs. Babies', '[object Object] 🤪', 'Cards against Humanity', 'Throw Throw Burrito',
      ]
      events = []
    number.times do |idx|
      event_idx = idx + 1
      start_date_time = Faker::Time.between(1.weeks.ago, 3.weeks.from_now)
      end_date_time = start_date_time + [120,180,240,300,360].sample.minutes 
      
      event = {
        organiser: User.all.sample,
        title: titles.sample,
        location: Faker::Restaurant.name,
        start_date_time: start_date_time,
        end_date_time: end_date_time,
      }
      events << event
    end
    Event.create(events)
    Event.all
  end

  def create_comment(author, commentable)
    creation_time = Faker::Time.backward(10)
    comment_text = [
      Faker::Movies::HitchhikersGuideToTheGalaxy.quote,
      Faker::Movies::BackToTheFuture.quote,
      Faker::Movies::Lebowski.quote,
      Faker::Movies::Ghostbusters.quote,
      Faker::Movie.quote,
      Faker::TvShows::TheITCrowd.quote,
      Faker::TvShows::Simpsons.quote,
      Faker::TvShows::GameOfThrones.quote,
    ].sample
    Comment.create(
      author: author,
      commentable: commentable, 
      comment_text: comment_text,
      created_at: creation_time,
      updated_at: creation_time,
      )
  end

  def create_comments(users, commentable, count)
    count.times do
      create_comment(users.sample, commentable)
    end
  end
  
  puts '==> Users'
  users = create_users(20)
  puts '==> Users done'
  
  puts '==> Events'
  events = create_events(12)
  puts '==> Events done'
  
  puts '==> Attendance with comments'
  events.each do |event|
    attendees = User.all.sample((0..5).to_a.sample)
    attendees << event.organiser
    attendees.uniq.each do |attendee|
      Attendance.create(attendee: attendee, event: event)
    end
    create_comments(users, event, (0..5).to_a.sample)
  end
  attendances = Attendance.all
  puts '==> Attendance with comments done'
  
  
  puts '==> Gamepieces with comments'
  users.each do |user|
    number_of_games = (0..10).to_a.sample
    users_games = games.sample(number_of_games)
    users_games.each do |game|
      gp = Gamepiece.create(owner: user, game: game)
      create_comments(users, gp, (0..5).to_a.sample)
    end
  end
  puts '==> Gamepieces with comments done'
  
  puts '==> Eventgames'
  attendances.each do |attendance|
    gamepieces = attendance.attendee.gamepieces
    library_size = gamepieces.size
    next if library_size < 1

    brought_games = gamepieces.sample((0..library_size-1).to_a.sample)
    brought_games.each do |gamepiece|
      Eventgame.create(gamepiece: gamepiece, attendance: attendance)
    end
  end
  puts '==> Eventgames done'

# end