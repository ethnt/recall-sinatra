class UserDestroy < Mutations::Command
  required do
    model :current_user, class: User
    hash :user do
      string :id
    end
  end

  def execute
    u = User.find(self.user['id'])

    if current_user.can_destroy?(u)
      u.destroy

      return nil
    else
      add_error(:current_user, 'the current user is not authorized')
    end
  end
end
