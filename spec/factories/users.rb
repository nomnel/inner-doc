FactoryGirl.define do
  factory :user do
    username Faker::Name.name
    email Faker::Internet.email
    pw = Faker::Internet.password
    password pw
    password_confirmation pw
    admin false

    factory :invalid_user do
      username nil
    end

    factory :admin do
      admin true
    end
  end
end
