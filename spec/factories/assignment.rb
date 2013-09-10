FactoryGirl.define do
  factory :assignment do
    text 'Write Recall tests'

    user
    course
  end
end
