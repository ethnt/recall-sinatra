require 'spec_helper'

describe Course do
  let(:course) { create :course }
  let(:user)   { course.user }

  it { expect(course).to be_valid }

  it { expect(course).to validate_presence_of :name }
end
