require 'spec_helper'

describe User do
  let(:user)  { create :user }
  let(:other) { create :user }
  let(:admin) { create :user, :admin }

  it { expect(user).to be_valid }

  it { expect(user).to validate_presence_of :email }

  it { expect(user).to validate_uniqueness_of :email }

  describe '#updatable_by?' do
    it { expect(user.updatable_by?(user)).to eql true }
    it { expect(user.updatable_by?(other)).to be false }
    it { expect(user.updatable_by?(admin)).to be true }
  end

  describe '#destroyable_by?' do
    it { expect(user.destroyable_by?(user)).to eql true }
    it { expect(user.destroyable_by?(other)).to be false }
    it { expect(user.destroyable_by?(admin)).to be true }
  end
end
