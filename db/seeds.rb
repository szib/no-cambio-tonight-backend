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

  create_users(10)

  Event.create(organiser_id: 1, title: 'Event1')
  Event.create(organiser_id: 2, title: 'Event2')

  Attendance.create(attendee_id: 2, event_id: 1)
  Attendance.create(attendee_id: 5, event_id: 1)
  Attendance.create(attendee_id: 5, event_id: 2)
  Attendance.create(attendee_id: 6, event_id: 2)
end