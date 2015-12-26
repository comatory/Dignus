FactoryGirl.define do
  factory :review, class: 'Review' do
    user_id 1
    to 2
    event_id 1
    rating 5
    text "this is review"
  end
end
