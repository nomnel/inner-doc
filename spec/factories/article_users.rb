# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article_user do
    article nil
    user nil
  end
end
