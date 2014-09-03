FactoryGirl.define do
  sequence :email do |n|
    "les#{n}@getrecall.co"
  end

  factory :user do
    email

    password 'recall123456'

    trait :admin do
      admin true
    end
  end
end
