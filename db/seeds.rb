# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env == 'development'
  Genre.create([
    { name: 'Ruby'},
    { name: 'Ruby on Rails4'},
    { name: 'Ruby on Rails5'},
    { name: 'Python2'},
    { name: 'Python3'},
    { name: 'Django2'}
  ])

  User.create(
    {
      username: 'alice',
      password: 'password',
      password_confirmation: 'password',
      email: 'alice@test.com'
    }
  )

  (1..50).each do |i|
    room = Room.new(title: "title#{i}", description: "very long description for this room. this room is about hogehoge. It is maybe good for you.#{i}" * 5, genre_ids: [Genre.find_by(name: 'Ruby').id, Genre.find_by(name: 'Python2').id], user_id: User.all.first.id)
    # genre_Ruby = room.room_genre_relations.build
    # genre_Python2 = room.room_genre_relations.build
    # genre_Ruby.genre = Genre.find_by(name: 'Ruby')
    # genre_Python2.genre = Genre.find_by(name: 'Python2')
    room.save!
  end

  (1..10).each do |i|
    message = Message.new(content: "comment#{i}", user_id:  User.all.first.id, room_id: Room.all.first.id)
    message.save!
  end
end
