require 'spec_helper'

describe CourseUpdate do
  let(:course) { create :course }

  context 'authorized user' do
    let(:user)   { course.user }
    
    let(:action) do
      CourseUpdate.run(
        current_user: user,
        course: {
          id: course.id.to_s,
          name: 'Software Development I',
          code: 'CMPT105',
          hidden: true
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Course }
    it { expect(action.result.name).to eql 'Software Development I' }
    it { expect(action.result.code).to eql 'CMPT105' }
    it { expect(action.result.hidden).to eql true }
  end

  context 'unauthorized user' do
    let(:other) { create :user }

    let(:action) do
      CourseUpdate.run(
        current_user: other,
        course: {
          id: course.id.to_s,
          name: 'Software Development I',
          code: 'CMPT105',
          hidden: true
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
