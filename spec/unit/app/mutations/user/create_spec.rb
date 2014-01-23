require 'spec_helper'

describe UserCreate do
  let(:action) do
    UserCreate.run(
      user: {
        email: 'foo@bar.com'
      },
      password: {
        password: 'foobar',
        confirm:  'foobar'
      }
    )
  end

  it { action.success?.should be_true }
  it { action.result.should be_an_instance_of User }
  it { action.result.email.should eql 'foo@bar.com' }
end
