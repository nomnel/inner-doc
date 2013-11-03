FactoryGirl.define do
  factory :article do
    title Faker::Lorem.words(num = [*1..5].sample).join(' ')
    content Faker::Lorem.paragraphs.join("\n")

    factory :invalid_article do
      title nil
    end
  end
end
