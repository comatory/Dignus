# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all

puts "--- DB CLEANED ---"

def password_digest
  alpha = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
  password = []
  8.times { password << alpha[rand(alpha.length - 1)]}
  password.join()
end

5.times do

    u = User.create(email: Faker::Internet.email, password: password_digest, 
                organizer: true, performer: false, organizer_name: Faker::Company.name,
                organizer_description: Faker::Lorem.sentence(6), 
                location: Faker::Address.city
               )  
    
    Event.create(user_id: u.id, name: Faker::Company.name + ' event', start: Faker::Time.forward(5),
                 end: Faker::Time.forward(6), description: Faker::Lorem.sentence(3), venue: Faker::Company.name + ' club')

    User.create(email: Faker::Internet.email, password: password_digest, 
                organizer: false, performer: true, performer_name: Faker::Company.name,
                performer_description: Faker::Lorem.sentence(6), 
                location: Faker::Address.city
               )  
end

puts "--- DB REPOPULATED ---"
