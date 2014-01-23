require 'spec_helper'

describe 'Summary' do
  let(:user) { create :user }

  describe ':weekly' do
    let(:mail) do
      Recall::Web.deliver(:summary, :weekly, user)
    end

    it { mail.to.first.should eql user.email }
  end
end
