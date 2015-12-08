# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CanceledInvitation.destroy_all
Invitation.destroy_all
Review.destroy_all
User.destroy_all
Content.destroy_all
Event.destroy_all
Location.destroy_all

audio_path = "#{Rails.root}/public/system/contents/audios/"
poster_path = "#{Rails.root}/public/system/events/posters/"
avatar_path = "#{Rails.root}/public/system/users/avatars/"

FileUtils.rm_rf(Dir.glob("#{audio_path}*"))
FileUtils.rm_rf(Dir.glob("#{poster_path}*"))
FileUtils.rm_rf(Dir.glob("#{avatar_path}*"))

puts "--- DB CLEANED ---"

locations = [
  {
    "place_id": "ChIJa7qpPRmjpBIRW_sqzl9PWy8",
    "latitude": 41.3971646,
    "longitude": 2.188156,
    "place_name": "Sala Rocksound",
    "place_address": "Carrer Almogàvers, 116, 08018 Barcelona, Spain",
    "place_website": "salarocksound.com",
    "place_url": "https://goo.gl/maps/pnpM7HfGRUB2"

  },
  {
    "place_id": "ChIJVzOPbRlD04kRHy8PzhOp4Q8",
    "latitude": 43.0912783,
    "longitude": -79.0743031,
    "place_name": "Hard Rock Cafe",
    "place_address": "5705 Falls Ave, Niagara Falls, ON L2H 6T3, Canada",
    "place_website": "hardrock.com",
    "place_url": "https://goo.gl/maps/F28XE9yepqz"

  },
  {
    "place_id": "ChIJjWFUe-gJxkcRx1_NUFX-23U",
    "latitude": 52.3648651,
    "longitude": 4.8796894,
    "place_name": "Sugarfactory",
    "place_address": "Lijnbaansgracht 238, 1017 PH Amsterdam, Netherlands",
    "place_website": "sugarfactory.nl",
    "place_url": "https://goo.gl/maps/Tr9iw8ShLQM2"
  },
  {
    "place_id": "ChIJ65wTQEFKtUYR7gGkOFaqpO0",
    "latitude": 55.7654497,
    "longitude": 37.6088046,
    "place_name": "Artefaq",
    "place_address": "ul. Bolshaya Dmitrovka, 32, стр. 1, Moskva, Russia, 125009",
    "place_website": "",
    "place_url": "https://goo.gl/maps/yGT9GwMqYyT2"
  },
  {
    "place_id": "ChIJsTxURtY3zDER55KkmLaRuRs",
    "latitude": 3.1579164,
    "longitude": 101.7062503,
    "place_name": "Zouk Klub",
    "place_address": "50250 Kuala Lumpur Wilayah Persekutuan Kuala Lumpur, Malaysia",
    "place_website": "http://www.zoukclub.com.my/",
    "place_url": "https://goo.gl/maps/aqGR8iC6J1m"
  }
]

locations_db = locations.map do |location|
  Location.create(latitude: location[:latitude], longitude: location[:longitude], place_id: location[:place_id], 
                 place_name: location[:place_name], place_address: location[:place_address], place_website: location[:place_website],
                 place_url: location[:place_url])
end

password = "12345678"

performers = [
  { "name": "Lewis Fautzi", 
    "description": "The gleam of cosmic light reflects on polished surfaces, which sometimes trace long smooth curves, other times end in edges, outlining a powerful machine piercing a path between the gravitational pull of a black hole, and the attraction of the brightness of a newly-born star. If Lewis Fautzi´s sound could be materialized, it would look something like this.",
    "location": "Madrid, Spain",
    "image": "06.jpg",
    "files": ["IC-10.mp3"],
    "youtube": "https://www.youtube.com/watch?v=Y0CX3nr-Hn8",
    "website": "https://www.facebook.com/lewisfautziofficial/"
  },
  { "name": "Los Crudos", 
    "description": "DIY political hardcore punk band from Chicago, Illinois fronted by vocalist Martin Sorrondeguy. All of the band members were of Latino descent and all of their lyrics were in Spanish. They formed in 1991 and their last show was in October 1998.",
    "location": "Chicago, USA",
    "image": "07.jpg",
    "files": ["01 Achicados.mp3", "02 En Mi Opinion.mp3", "03 No Te Debo Nado.mp3", "04 Levantante!.mp3", "05 La Caida De Latino America.mp3"],
    "youtube": "https://www.youtube.com/watch?v=_Y4asIi3yNs&list=RD5DEe1TStXCM&index=5",
    "website": "https://es.wikipedia.org/wiki/Los_Crudos"
  },
  {"name": "Vril", 
    "description": "Vril has been building a strong reputation for his live performances. He's become increasingly busy over the last 12 months, with gigs in an impressive number of countries, and he'll set out this week on his first US tour, with stops in Miami, New York, Washington DC and Philadelphia.",
    "location": "Hannover, Denmark",
    "image": "08.jpg",
    "files": ["IAMIX146Vril.mp3", "03 Portal 3.mp3"],
    "youtube": "https://www.youtube.com/watch?v=y2s_PH25OB0",
    "website": "http://www.residentadvisor.net/dj/vril"
    },
  { "name": "Midi Lidi", 
    "description": "Electro-pop band Midi Lidi was formed and built in 2006 around the backbone of the band The Beautiful Removal Man Gerard & Sexual Furniture. Up until 2011, the band members were Petr Marek (vocals, electronics, keyboards), Marketa Lisa (vocals, electronics, keyboards, saxophone), Prokop Holoubek (vocals, drums, keyboards, clarinet, guitar) and three visual artists Filip Cenek, Magdalena Hruba and Jan Sramek, all of whom were responsible for creating the live visuals, album covers, posters and T-shirts.",
    "image": "09.jpg",
    "location": "Brno, Czech Republic",
    "files": ["20 Jellybelly - Miami Vice (Midi Lidi Kutya Remix).mp3", "Bujon (live Fléda 2012).mp3"],
    "youtube": "https://www.youtube.com/watch?v=jjxhXSYIOlA",
    "website": "http://www.bumbumsatori.org/artists/midi-lidi/"
    },
    { "name": "Kamp!", 
    "description": "Kamp! has been around for a while having grown a massive domestic popularity in their native Poland and a niche global fanbase thanks to their smooth synth pop, that brings the new-wave feel to the retro chic of disco.",
    "location": "Warsaw, Poland",
    "image": "10.jpg",
    "files": ["02 Cairo.mp3", "04 Sulk.mp3", "06 Lux Lisbon.mp3", "07 Distance of the modern hearts.mp3"],
    "youtube": "https://www.youtube.com/watch?v=yhHzY_Au-9c",
    "website": "https://www.facebook.com/kampmusik"
    }
]

organizers = [
  { "name": Faker::Name.name, 
    "description": "Hardcore thinker. Organizer. Food lover. Incurable coffee evangelist. Certified gamer. Alcohol expert. Tv practitioner.",
    "location": "Barcelona, Spain",
    "image": "01.jpg"},
    { "name": Faker::Name.name, 
    "description": "Infuriatingly humble social media nerd. Internet expert. Tv geek. Food lover.",
    "location": "Niagara Falls, Canada",
    "image": "02.jpg"},
  {"name": Faker::Name.name, 
    "description": "Total travel nerd. Friendly zombie guru. Infuriatingly humble thinker. Music aficionado.",
    "location": "Amsterdam, Netherlands",
    "image": "03.jpg"},
  { "name": Faker::Name.name, 
    "description": "Beer specialist. Web lover. Coffee guru. Zombie maven. Extreme thinker. Wannabe twitter junkie.",
    "image": "04.jpg",
    "location": "Moscow, Russia"},
    { "name": Faker::Name.name, 
    "description": "Beeraholic. Incurable twitter lover. Avid music evangelist. Bacon ninja. Future teen idol.",
    "location": "Kuala Lumpur, Malaysia",
    "image": "05.jpg"}
]

events = [
  {
    "name": "Crush your bones",
    "description": "This will be great showcase of some great bands.",
    "location_id": locations_db[0].id,
    "image": "11.png"
  },
  {
    "name": "Soul Marmelade",
    "description": "Come for some smooth sounds.",
    "location_id": locations_db[1].id,
    "image": "12.png"
  },
  {
    "name": "Night Shift",
    "description": "Amsterdam's best residents, spinning the decks.",
    "location_id": locations_db[2].id,
    "image": "13.png"
  },
  {
    "name": "Headbanging vol. 12",
    "description": "Come and have some fun in the moshpit.",
    "location_id": locations_db[3].id,
    "image": "14.png"
  },
  {
    "name": "ZHX3204",
    "description": "Only robots invited.",
    "location_id": locations_db[4].id,
    "image": "15.png"
  },
]

past_events = [
  {
    "name": "Beirut",
    "description": "Event from past - Beirut.",
    "location_id": locations_db[0].id,
    "image": "16.png"
  },
  {
    "name": "Horse Party",
    "description": "Part for horses.",
    "location_id": locations_db[1].id,
    "image": "17.png"
  },
  {
    "name": "BLABLABLA",
    "description": "This is nonsense.",
    "location_id": locations_db[2].id, 
    "image": "18.png"
  },
  {
    "name": "Ela Orleans",
    "description": "January 13th, Prague will receive Ela Orleans, the crown princess of UK experimental pop. Her music combines nostalgic dark melodies with endless audio loops, dreamy lo-fi or abstract violin howls – which is possibly why she calls her music “movies for ears. .",
    "location_id": locations_db[3].id ,
    "image": "19.png"
  },
  {
    "name": "Ride",
    "description": "Waving farewell to the Eighties: it was biggest pop kick there’d been in, ooh, ten years. During that godforsaken, musically atrocious decade, it was them and us..",
    "location_id": locations_db[4].id,
    "image": "20.png"
  },
]

performers_db = []
organizers_db = []
tag_list = ["rock", "pop", "hip-hop", "spoken word", "seen live", "happy", "sad", "czech", "USA", "french", "electronic", "non-profit", "crazy",
            "audience", "funny", "comedy", "drama", "improvisation", "rural", "urban", "trippy", "norm-core", "event-hacking"
            ]


5.times do |i|

    ptags = ""
    8.times { |i| ptags += "#{tag_list[rand(tag_list.length - 1)]}, " }

    p = User.create(email: Faker::Internet.email, password: "12345678", 
                organizer: false, performer: true, location: performers[i][:location],
               )  
    p.contents.create(role: 1, content_type: 1, content: performers[i][:name])
    p.contents.create(role: 1, content_type: 2, content: performers[i][:description])
    p.update(avatar: File.new("#{Rails.root}/faker/#{performers[i][:image]}"))
    p.contents.create(role: 1, content_type: 4, content: performers[i][:youtube] )
    p.contents.create(role: 1, content_type: 5, content: performers[i][:website] )
    p.tag_list = ptags
    p.save

    if performers[i][:files]
      performers[i][:files].each do |file|
        p.contents.create(role: 1, content_type: 3, content: "", audio: File.new("#{Rails.root}/faker/#{file}"))
      end
    end

    otags = ""
    8.times { |i| otags += "#{tag_list[rand(tag_list.length - 1)]}, " }

    o = User.create(email: Faker::Internet.email, password: "12345678", 
                organizer: true, performer: false, location: organizers[i][:location],
               )  
    o.contents.create(role: 0, content_type: 1, content: organizers[i][:name])
    o.contents.create(role: 0, content_type: 2, content: organizers[i][:description])
    o.update(avatar: File.new("#{Rails.root}/faker/#{organizers[i][:image]}"))
    o.tag_list = otags
    o.save
    
    etags = ""
    8.times { |i| etags += "#{tag_list[rand(tag_list.length - 1)]}, " }
    e = Event.create(user_id: o.id, name: events[i][:name], start_time: Faker::Time.forward(5),
                 end_time: Faker::Time.forward(6), description: events[i][:description], location_id: events[i][:location_id],
                 poster: File.new("#{Rails.root}/faker/#{events[i][:image]}")
                )
    e.tag_list = etags
    e.save


    o.invitations.create(to: p.id, event_id: o.events.first.id, accepted: false, rejected: false, responded: false)

    performers_db << p
    organizers_db << o
end

Invitation.find_by(to: performers_db.last.id).update(accepted: true, responded: true)

if Rails.env.development? || Rails.env.test?
  ValidatesTimeliness.setup do |config|
    config.ignore_restriction_errors = true 
   end
end

organizers_db[0..2].each_with_index do |o, index|
    date = DateTime.new(rand(2010..2014),rand(1..12),rand(1..20), 19,0)
    e = Event.create(user_id: o.id, name: past_events[index][:name], start_time: date,
                 end_time: date + 0.2, description: past_events[index][:description], location_id: past_events[index][:location_id],
                 poster: File.new("#{Rails.root}/faker/#{past_events[index][:image]}")
                )
    i = performers_db[index].invitations.create(to: o.id, event_id: e.id, accepted: true, rejected: false, responded: true)
    r1 = Review.create(user_id: organizers_db[index].id, to: performers_db[index].id, rating: rand(0..5), event_id: e.id,
                  text: "#{performers_db[index].name} was at my event and it was #{['ok', 'great', 'good','bad'][rand(0..3)]}" )
    r2 = Review.create(user_id: performers_db[index].id, to: organizers_db[index].id, rating: rand(0..5), event_id: e.id,
                  text: "#{organizers_db[index].name} had a nice event and it was #{['ok', 'great', 'good','bad'][rand(0..3)]}" )
end


date = DateTime.new(rand(2010..2014),rand(1..12),rand(1..20), 19,0)
e = Event.create(user_id: organizers_db[3].id, name: past_events[3][:name], start_time: date,
             end_time: date + 0.2, description: past_events[3][:description], location_id: past_events[3][:location_id],
             poster: File.new("#{Rails.root}/faker/#{past_events[3][:image]}")
            )
e2 = Event.create(user_id: organizers_db[3].id, name: past_events[4][:name], start_time: date,
             end_time: date + 0.2, description: past_events[4][:description], location_id: past_events[4][:location_id],
             poster: File.new("#{Rails.root}/faker/#{past_events[4][:image]}")
            )
i = performers_db[3].invitations.create(to: organizers_db[3].id, event_id: e.id, accepted: true, rejected: false, responded: true)
i = performers_db[3].invitations.create(to: organizers_db[3].id, event_id: e2.id, accepted: true, rejected: false, responded: true)
r1 = Review.create(user_id: organizers_db[3].id, to: performers_db[3].id, rating: rand(0..5), event_id: e.id,
              text: "#{performers_db[3].name} was at my event and it was #{['ok', 'great', 'good','bad'][rand(0..3)]}" )
r2 = Review.create(user_id: organizers_db[3].id, to: performers_db[3].id, rating: rand(0..5), event_id: e2.id,
              text: "#{performers_db[3].name} was at my event and it was #{['ok', 'great', 'good','bad'][rand(0..3)]}" )

puts "--- performers ---"
performers_db.each_with_index do |performer, i|
  puts "#{i} | #{performer.email} | #{performer.id}"
  if i == 3
    puts "--->"
  end
end

puts "--- DB REPOPULATED ---"
