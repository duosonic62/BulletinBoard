# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env == 'development'
  Tag.create([
    { name: 'Ruby'},
    { name: 'Ruby on Rails4'},
    { name: 'Ruby on Rails5'},
    { name: 'Python2'},
    { name: 'Python3'},
    { name: 'Django2'}
  ])

  User.create([
    {
      username: 'alice',
      password: 'password',
      password_confirmation: 'password',
      email: 'alice@test.com'
    },
    {
      username: 'bob',
      password: 'password',
      password_confirmation: 'password',
      email: 'bob@test.com'
    },
  ])

  (1..50).each do |i|
    room = Room.new(title: "titletitletitle#{i}", description: "very long description for this room. this room is about hogehoge. It is maybe good for you.#{i}" * 2, tag_ids: [Tag.find_by(name: 'Ruby').id, Tag.find_by(name: 'Python2').id], user_id: User.all.first.id)
    # Tag_Ruby = room.room_Tag_relations.build
    # Tag_Python2 = room.room_Tag_relations.build
    # Tag_Ruby.Tag = Tag.find_by(name: 'Ruby')
    # Tag_Python2.Tag = Tag.find_by(name: 'Python2')
    room.save!
  end

  (1..10).each do |i|
    message = Message.new(content: "comment#{i}", user_id:  User.all.first.id, room_id: Room.all.first.id)
    message.save!
  end
end
