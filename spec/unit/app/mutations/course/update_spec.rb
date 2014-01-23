require 'spec_helper'

describe CourseUpdate do
  let(:course) { create :course }
  let(:user)   { course.user }
  let(:action) do
    CourseUpdate.run(
      current_user: user,
      course: {
        id:   course.id.to_s,
        name: 'Intro to Programming',
        code: course.code
      }
    )
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of Course }
  it { action.result.name.should eql 'Intro to Programming' }
end
