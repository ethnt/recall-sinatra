require 'spec_helper'

describe Assignment do
  let(:assignment) { create :assignment }
  let(:course)     { assignment.course }
  let(:user)       { course.user }
  let(:other)      { create :user }
  let(:admin)      { create :user, :admin }

  it { expect(assignment).to be_valid }

  it { expect(assignment).to validate_presence_of :text }

  describe '#creatable_by?' do
    it { expect(assignment.viewable_by?(user)).to eql true }
    it { expect(assignment.viewable_by?(other)).to eql false }
    it { expect(assignment.viewable_by?(admin)).to eql true }
  end

  describe '#viewable_by?' do
    it { expect(assignment.viewable_by?(user)).to eql true }
    it { expect(assignment.viewable_by?(other)).to eql false }
    it { expect(assignment.viewable_by?(admin)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(assignment.updatable_by?(user)).to eql true }
    it { expect(assignment.updatable_by?(other)).to eql false }
    it { expect(assignment.updatable_by?(admin)).to eql true }
  end

  describe '#destroyable_by?' do
    it { expect(assignment.destroyable_by?(user)).to eql true }
    it { expect(assignment.destroyable_by?(other)).to eql false }
    it { expect(assignment.destroyable_by?(admin)).to eql true }
  end
end
