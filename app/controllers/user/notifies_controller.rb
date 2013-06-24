class User::NotifiesController < User::BaseController
  before_filter :authenticate_user!
  layout 'simpliq_application'
  
  def index
    @notifies = current_user.notifies
  end

  def show
    @notify = current_user.notifies.where(:id => params[:id]).first
  end

  def new
    @notify = current_user.notifies.new
  end

  def edit
    @notify = current_user.notifies.where(:id => params[:id]).first
  end

  def create
    @notify = current_user.notifies.new(params[:notify])

    respond_to do |format|
      if @notify.save
        format.html { 
          redirect_to user_notifies_path, notice: 'Notify was successfully created.' 
        }
      else
        format.html { 
          render action: "new" 
        }
      end
    end
  end

  def update
    @notify = current_user.notifies.where(:id => params[:id]).first

    respond_to do |format|
      if @notify.update_attributes(params[:notify])
        format.html { 
          redirect_to user_notifies_path, notice: 'Notify was successfully updated.' 
        }
      else
        format.html { 
          render action: "edit" 
        }
      end
    end
  end

  def destroy
    @notify = current_user.notifies.where(:id => params[:id]).first
    @notify.destroy

    respond_to do |format|
      format.html { 
        redirect_to user_notifies_pathnotice: 'Notify was successfully deleted.' 
      }
    end
  end
end
