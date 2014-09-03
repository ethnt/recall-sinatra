require 'spec_helper'

describe Assignment do
  let(:assignment) { create :assignment }
  let(:course)     { assignment.course }
  let(:user)       { course.user }

  it { expect(assignment).to be_valid }

  it { expect(assignment).to validate_presence_of :text }
end
