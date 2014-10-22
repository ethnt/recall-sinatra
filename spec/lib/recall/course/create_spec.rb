require 'spec_helper'

describe CourseCreate do
  let(:user) { create :user }

  let(:action) do
    CourseCreate.run(
      current_user: user,
      course: {
        name: 'Intro to Programming',
        code: 'CMPT101'
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Course }
end
