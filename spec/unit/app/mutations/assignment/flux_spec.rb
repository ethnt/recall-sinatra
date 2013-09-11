require 'spec_helper'

describe AssignmentFlux do
  let(:assignment) { create :assignment }
  let(:user)       { assignment.course.user }
  let(:action) do
    AssignmentFlux.run({
      current_user: user,
      assignment: {
        id: assignment.id.to_s
      }
    })
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of Assignment }
  it { action.result.complete.should be_true }
end
