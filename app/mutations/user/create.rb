class UserCreate < Mutations::Command
  required do
    hash :user do
      string :email
      string :password
    end
  end

  def execute
    u = User.create(self.user)

    Analytics.track(
      user_id: u.id.to_s,
      event: 'User Created',
      timestamp: Time.now
    )

    return u
  end
end
