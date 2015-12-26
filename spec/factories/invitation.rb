FactoryGirl.define do
  factory :invitation, class: 'Invitation' do
    user_id 100
    event_id 1
    to 101
    accepted true
    responded true
  end
end
