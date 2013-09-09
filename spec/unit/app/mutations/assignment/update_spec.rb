require 'spec_helper'

describe AssignmentUpdate do
  let(:assignment) { create :assignment }
  let(:user)       { assignment.course.user }
  let(:action) do
    AssignmentUpdate.run({
      current_user: user,
      assignment: {
        id: assignment.id.to_s,
        text: 'Write tests'
      }
    })
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of Assignment }
  it { action.result.text.should eql 'Write tests' }
end
