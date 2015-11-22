# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Content.destroy_all
Event.destroy_all
Invitation.destroy_all

puts "--- DB CLEANED ---"

5.times do

    o = User.create(email: Faker::Internet.email, password: "12345678", 
                organizer: true, performer: false, location: Faker::Address.city,
               )  
    o.contents.create(role: 0, content_type: 1, content: Faker::Company.name)
    o.contents.create(role: 0, content_type: 2, content: Faker::Lorem.sentence(2))
    
    Event.create(user_id: o.id, name: Faker::Company.name + ' event', start: Faker::Time.forward(5),
                 end: Faker::Time.forward(6), description: Faker::Lorem.sentence(3), venue: Faker::Company.name + ' club')

    p = User.create(email: Faker::Internet.email, password: "12345678", 
                organizer: false, performer: true, location: Faker::Address.city,
               )  
    p.contents.create(role: 1, content_type: 1, content: Faker::Name.name)
    p.contents.create(role: 1, content_type: 2, content: Faker::Lorem.sentence(2))
end

puts "--- DB REPOPULATED ---"
