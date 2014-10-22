class UserUpdate < RecallMutation
  required do
    model :current_user, class: User
    hash :user do
      string :id
      string :email
      string :password
      string :password_confirmation
    end
  end

  def execute
    u = User.find(user['id'])

    unless current_user.can_update?(u)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    u.update_attributes(user)

    mongoid_errors!(u)

    u.save

    u
  end
end
