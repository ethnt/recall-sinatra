require 'spec_helper'

describe AssignmentDestroy do
  let(:assignment) { create :assignment }
  let(:course)     { assignment.course }

  context 'authorized user' do
    let(:user) { course.user }

    let(:action) do
      AssignmentDestroy.run(
        current_user: user,
        assignment: {
          id: assignment.id.to_s,
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to eql nil }
  end

  context 'unauthorized user' do
    let(:other) { create :user }

    let(:action) do
      AssignmentDestroy.run(
        current_user: other,
        assignment: {
          id: assignment.id.to_s
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
