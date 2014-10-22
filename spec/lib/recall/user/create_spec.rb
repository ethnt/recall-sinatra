require 'spec_helper'

describe UserCreate do
  let(:action) do
    UserCreate.run(
      user: {
        email: 'neil.tyson@hayden.org',
        password: 'cosmos123',
        password_confirmation: 'cosmos123'
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of User }
end
