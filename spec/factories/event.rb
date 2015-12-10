FactoryGirl.define do
  factory :event, class: 'Event' do
    name  Faker::Lorem.word
    description Faker::Lorem.sentence(3)
    start_time Faker::Time.forward(3)
    end_time Faker::Time.forward(20)
    location_id 1
  end
end
