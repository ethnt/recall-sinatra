require 'spec_helper'

describe Course do
  let(:course) { create :course }
  let(:user)   { course.user }
  let(:other)  { create :user }

  it { should validate_presence_of :name }

  it { course.should be_valid }

  describe '#viewable_by?' do
    it { course.viewable_by?(user).should be_true }
    it { course.viewable_by?(other).should be_false }
  end

  describe '#updatable_by?' do
    it { course.updatable_by?(user).should be_true }
    it { course.updatable_by?(other).should be_false }
  end

  describe '#destroyable_by?' do
    it { course.destroyable_by?(user).should be_true }
    it { course.destroyable_by?(other).should be_false }
  end
end
