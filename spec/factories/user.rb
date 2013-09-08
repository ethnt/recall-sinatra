FactoryGirl.define do
  sequence :email do |n|
    "neiltyson#{n}@hyden.org"
  end

  factory :user do
    email
    password 'foobar'
  end
end
