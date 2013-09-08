require 'spec_helper'

describe Course do
  let(:course) { create :course }
  let(:user)   { course.user }

  it { should validate_presence_of :name }

  it { course.should be_valid }
end
