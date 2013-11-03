FactoryGirl.define do
  factory :user do
    username Faker::Name.name
    email Faker::Internet.email
    pw = Faker::Internet.password
    password pw
    password_confirmation pw

    factory :invalid_user do
      username nil
    end
  end
end
