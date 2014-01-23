require 'spec_helper'

describe CourseDestroy do
  let(:course) { create :course }
  let(:user)   { course.user }
  let(:action) do
    CourseDestroy.run(
      current_user: user,
      course: {
        id: course.id.to_s
      }
    )
  end

  it { action.success?.should be_true }
  it { action.result.should be_nil }
end
