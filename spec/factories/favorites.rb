FactoryBot.define do

  factory :favorite do
    job_id { Faker::Hipster.words(number: 4).join('-') }
    email { Faker::Internet.email }
  end
end
