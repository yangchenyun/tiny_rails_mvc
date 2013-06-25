require 'models/user'

class UsersController < Controller
  def index
    @users = User.find_all
  end

  def show
    @user = User.find(request['id'])
  end
end
