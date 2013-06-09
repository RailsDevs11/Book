class User::ProfilesController < User::BaseController
  before_filter :authenticate_user!

  #it will fetch the data of current user and will show on the profile page.
  def show
    @user = User.find(current_user)
  end
  
  def destroy
    @user = current_user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Your account was successfully deleted.'  }
    end
  end

end
