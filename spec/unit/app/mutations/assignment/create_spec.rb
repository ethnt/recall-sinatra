require 'spec_helper'

describe AssignmentCreate do
  let(:course) { create :course }
  let(:user)   { course.user }
  let(:action) do
    AssignmentCreate.run(
      current_user: user,
      course: course,
      assignment: {
        text: 'Make a website',
        due:  DateTime.now + 1
      }
    )
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of Assignment }
  it { action.result.text.should eql 'Make a website' }
end
