FactoryGirl.define do
  factory :user, class: 'User' do
    email Faker::Internet.email
    password "password"
    password_confirmation "password"
    confirmed_at  Time.now
  end
end
