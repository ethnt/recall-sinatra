FactoryGirl.define do
  factory :assignment do
    text  'Study for finals'
    due   Date.tomorrow

    course
  end
end
