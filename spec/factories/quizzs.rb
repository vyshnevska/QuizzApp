# require 'ffaker'
FactoryGirl.define do
  factory :quizz do
    description    { Faker::Lorem.words(3).join(" ") }
    status         'draft'
  end

  factory :quizz_with_qsts, :parent => :quizz do
    association :game
    after(:create) do |quizz|
      3.times do
        quizz.questions << FactoryGirl.create(:question_with_anws, quizz: quizz)
      end
    end
  end
end
