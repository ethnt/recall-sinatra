FactoryGirl.define do
  factory :reminder do
    time { Time.new + 1000 }

    assignment
  end
end
