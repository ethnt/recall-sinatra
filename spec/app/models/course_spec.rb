require 'spec_helper'

describe Course do
  let(:course) { create :course }
  let(:user)   { course.user }
  let(:other)  { create :user }
  let(:admin)  { create :user, :admin }

  it { expect(course).to be_valid }

  it { expect(course).to validate_presence_of :name }

  describe '#viewable_by?' do
    it { expect(course.viewable_by?(user)).to eql true }
    it { expect(course.viewable_by?(other)).to eql false }
    it { expect(course.viewable_by?(admin)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(course.updatable_by?(user)).to eql true }
    it { expect(course.updatable_by?(other)).to eql false }
    it { expect(course.updatable_by?(admin)).to eql true }
  end

  describe '#destroyable_by?' do
    it { expect(course.destroyable_by?(user)).to eql true }
    it { expect(course.destroyable_by?(other)).to eql false }
    it { expect(course.destroyable_by?(admin)).to eql true }
  end
end
