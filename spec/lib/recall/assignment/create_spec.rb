require 'spec_helper'

describe AssignmentCreate do
  let(:course) { create :course }

  context 'authorized user' do
    let(:user)   { course.user }

    let(:action) do
      AssignmentCreate.run(
        current_user: user,
        assignment: {
          text: 'Find the Higgs Boson',
          due: Date.tomorrow,
          complete: false,
          notes: nil,
          course_id: course.id.to_s,
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Assignment }
    it { expect(action.result.text).to eql 'Find the Higgs Boson' }
    it { expect(action.result.due).to eql Date.tomorrow }
    it { expect(action.result.complete).to eql false }
    it { expect(action.result.course).to eql course }
  end

  context 'unauthorized user' do
    let(:other) { create :user }

    let(:action) do
      AssignmentCreate.run(
        current_user: other,
        assignment: {
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
