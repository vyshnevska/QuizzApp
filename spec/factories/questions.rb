# require 'ffaker'
FactoryGirl.define do
  factory :question do
    title    { Faker::Lorem.sentence }
    quizz_id 1
  end

  factory :question_with_anws, :parent => :question do
    association :quizz
    after(:create) do |question|
      3.times do
        question.answers << FactoryGirl.create(:answer, question: question)
      end
    end
  end

end
