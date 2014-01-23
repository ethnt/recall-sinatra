require 'spec_helper'

describe CourseCreate do
  let(:user) { create :user }
  let(:action) do
    CourseCreate.run(
      current_user: user,
      course: {
        name: 'Programming 101',
        code: 'CMPT100N'
      }
    )
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of Course }
  it { action.result.name.should eql 'Programming 101' }
end
