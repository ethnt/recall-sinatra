require 'spec_helper'

describe CourseDestroy do
  let(:course) { create :course }

  context 'authorized user' do
    let(:user)   { course.user }

    let(:action) do
      CourseDestroy.run(
        current_user: user,
        course: {
          id: course.id.to_s,
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to eql nil }
  end

  context 'unauthorized user' do
    let(:other) { create :user }

    let(:action) do
      CourseDestroy.run(
        current_user: other,
        course: {
          id: course.id.to_s
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
