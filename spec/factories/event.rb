FactoryGirl.define do
  factory :event, class: 'Event' do
    name  Faker::Lorem.word
    description Faker::Lorem.sentence(3)
    venue Faker::Address.city
    start_time Faker::Time.forward(3)
    end_time Faker::Time.forward(20)
  end
end
