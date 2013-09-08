require 'spec_helper'

describe User do
  let(:user) { create :user }

  it { should validate_presence_of :email }

  it { user.should be_valid }

  describe '.authenticate' do
    let(:action) do
      User.authenticate(user.email, 'foobar')
    end

    it { action.should be_an_instance_of User }
    it { action.should eql user }
  end

  describe '#encrypt_password!' do
    it { user.hash.should_not be_nil }
    it { user.password.should == 'foobar' }
  end
end
