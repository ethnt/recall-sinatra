class UserCreate < Mutations::Command
  required do
    hash :user do
      string :email
    end
    hash :password do
      string :password
      string :confirm
    end
  end

  def execute
    u = User.new(self.user)

    if password['password'] == password['confirm']
      u.password = password['password']
      u.save

      Analytics.track(
        user_id: u.id.to_s,
        event: 'User Joined'
      )

      return u
    else
      add_error(:password, :not_matching, 'Passwords do not match')
    end
  end
end
