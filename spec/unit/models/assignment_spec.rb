require 'spec_helper'

describe Assignment do
  let(:assignment) { create :assignment }

  it { should validate_presence_of :text }

  it { assignment.should be_valid }
end
