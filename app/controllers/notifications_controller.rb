class NotificationsController < AuthenticatedController

  before_filter :check_user_is_owner, :only => [:show, :update, :destroy]

  add_breadcrumb "Notifications", :notifications_path

  def index
    @notifications = current_user.notifications.paginate(page: params[:page], per_page: 30)
  end

  def show

  end

  def new

  end

  def edit

  end

  def create

  end

  def update
    if params[:read].present?
      if params[:read].eql?("Read")
        current_user.mark_as_read @notification
      elsif params[:read].eql?("Unread")
        current_user.mark_as_unread @notification
      end
    end
    @notifications = @mailbox.notifications.not_trashed.page(params[:page]).per(10)
    render :action => :index
  end

  #TODO ?
  def update_all
    @notifications = @mailbox.notifications.all
    current_user.mark_as_read @notifications

    if request.xhr?
      render text: ''
    else
      redirect_to notifications_path
    end
  end

  def destroy
    @notification.move_to_trash
    @notifications = @mailbox.notifications.not_trashed
    render :action => :index
  end

  private

  def check_user_is_owner
    @notification = current_user.notifications.find_by_id(params[:id])
    if @notification.nil?
      redirect_to notifications_path;
    end
  end

end
