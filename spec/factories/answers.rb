require 'ffaker'
FactoryGirl.define do
  factory :answer do
    content       { Faker::Lorem.sentence }
    # correct       { false }
    association   :question
  end

end
