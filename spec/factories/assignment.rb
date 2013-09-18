FactoryGirl.define do
  factory :assignment do
    text 'Write Recall tests'
    due  Date.tomorrow

    user
    course
  end
end
