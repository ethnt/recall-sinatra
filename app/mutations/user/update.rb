class UserUpdate < Mutations::Command
  required do
    model :current_user, class: User
    hash :user do
      string :id
      string :email
    end
  end

  def execute
    u = User.find(user['id'])

    if current_user.can_update?(u)
      u.update_attributes(user)
      u.save

      return u
    else
      add_error(:current_user, 'the current user is not authorized')
    end
  end
end
