require 'spec_helper'

describe AssignmentDestroy do
  let(:assignment) { create :assignment }
  let(:user)       { assignment.course.user }
  let(:action) do
    AssignmentDestroy.run({
      current_user: user,
      assignment: {
        id: assignment.id.to_s,
      }
    })
  end

  it { action.success?.should be_true }
  it { action.result.should be_nil }
end
