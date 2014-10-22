require 'spec_helper'

describe UserUpdate do
  let(:user) { create :user }

  context 'authorized user' do
    let(:action) do
      UserUpdate.run(
        current_user: user,
        user: {
          id: user.id.to_s,
          email: 'foo@bar.com',
          password: 'cosmos321',
          password_confirmation: 'cosmos321'
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of User }
    it { expect(action.result.email).to eql 'foo@bar.com' }
    it { expect(action.result.password).to eql 'cosmos321' }
  end

  context 'unauthorized user' do
    let(:other) { create :user }

    let(:action) do
      UserUpdate.run(
        current_user: other,
        user: {
          id: user.id.to_s,
          email: 'foo@bar.com',
          password: 'cosmos321',
          password_confirmation: 'cosmos321'
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
