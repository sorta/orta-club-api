FactoryBot.define do
  factory :member do
    name_first { Faker::Name.first_name }
  end
end