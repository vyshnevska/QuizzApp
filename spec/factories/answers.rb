require 'ffaker'
FactoryGirl.define do
  factory :answer do |f|
    f.content       { Faker::Lorem.sentence }
    f.correct       false
    # f.correct       { false }
    association   :question
  end

end
