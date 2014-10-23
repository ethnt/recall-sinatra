require 'spec_helper'

describe AssignmentUpdate do
  let(:assignment) { create :assignment }
  let(:course)     { assignment.course }

  context 'authorized user' do
    let(:user)   { course.user }

    let(:action) do
      AssignmentUpdate.run(
        current_user: user,
        assignment: {
          id: assignment.id.to_s,
          text: 'Find the Higgs Boson',
          due: Date.tomorrow,
          complete: false,
          notes: 'Foo to the bar',
          course_id: course.id.to_s,
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Assignment }
    it { expect(action.result.text).to eql 'Find the Higgs Boson' }
    it { expect(action.result.due).to eql Date.tomorrow }
    it { expect(action.result.complete).to eql false }
    it { expect(action.result.notes).to eql 'Foo to the bar' }
    it { expect(action.result.course).to eql course }
  end

  context 'unauthorized user' do
    let(:other) { create :user }

    let(:action) do
      AssignmentUpdate.run(
        current_user: other,
        assignment: {
          id: assignment.id.to_s,
          text: 'Find the Higgs Boson',
          due: Date.tomorrow,
          complete: false,
          notes: nil,
          course_id: course.id.to_s
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
