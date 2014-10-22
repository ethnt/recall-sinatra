require 'spec_helper'

describe Reminder do
  let(:reminder)   { create :reminder }
  let(:assignment) { reminder.assignment }
  let(:course)     { assignment.course }
  let(:user)       { course.user }

  it { expect(reminder).to be_valid }

  it { expect(reminder).to validate_presence_of :time }

  describe '#email' do
    let(:email) { user.email }

    it { expect(reminder.email).to eql email }
  end
end
