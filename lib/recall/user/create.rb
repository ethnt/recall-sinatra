class UserCreate < RecallMutation
  required do
    hash :user do
      string :email
      string :password
      string :password_confirmation
    end
  end

  def execute
    u = User.new(user)

    mongoid_errors!(u)

    u.save

    u
  end
end
