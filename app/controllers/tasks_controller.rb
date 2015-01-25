class TasksController < AuthenticatedController
  include TasksHelper

  before_filter :check_user_is_owner, :only => [:toggle_done, :update, :destroy]

  respond_to :js

  def new
    @task = Task.new
  end

  def update
    @task.update_attributes(task_params)
    load_tasks_count
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save!
    else
      #TODO error
      #render :index
    end
    @tasks = current_user.tasks
  end

  def destroy
    @task.destroy!
    load_tasks_count
  end

  def list_all
    @tasks = current_user.tasks
    render action: 'list'
  end

  def list_pending
    @tasks = current_user.pending_tasks
    render action: 'list'
  end

  def list_done
    @tasks = current_user.done_tasks
    render action: 'list'
  end

  def list_overdue
    @tasks = current_user.overdue_tasks
    render action: 'list'
  end

  def toggle_done
    @task.toggle_done!
    load_tasks_count
  end


  private

  def task_params
    params.require(:task).permit(:name, :due_in)
  end

  def check_user_is_owner
    @task = current_user.tasks.find_by_id(params[:id])
    if @task.nil?
      redirect_to tasks_path
    end
  end

end
