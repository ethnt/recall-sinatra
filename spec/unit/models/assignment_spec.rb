require 'spec_helper'

describe Assignment do
  let(:assignment) { create :assignment }
  let(:course)     { assignment.course }
  let(:user)       { course.user }
  let(:other)      { create :user }

  it { should validate_presence_of :text }

  it { assignment.should be_valid }

  describe '#viewable_by?' do
    it { assignment.viewable_by?(user).should be_true }
    it { assignment.viewable_by?(other).should be_false }
  end

  describe '#updatable_by?' do
    it { assignment.updatable_by?(user).should be_true }
    it { assignment.updatable_by?(other).should be_false }
  end

  describe '#destroyable_by?' do
    it { assignment.destroyable_by?(user).should be_true }
    it { assignment.destroyable_by?(other).should be_false }
  end
end
