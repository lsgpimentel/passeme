class TasksController < AuthenticatedController
  include TasksHelper

  add_breadcrumb "Tasks", :index_path

  def new
    @task = Task.new
    respond_to do |format|
      format.js 
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update_attributes(task_params)
    respond_to do |format|
      format.js { render nothing: true }
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save!
    else
      #TODO error
      #render :index
    end
    @tasks = current_user.tasks
    respond_to do |format|
      format.js #{ render action: 'list' }
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy!
    respond_to do |format|
      format.js #{ render action: 'list' }
    end
  end

  def list_all
    @tasks = current_user.tasks
    respond_to do |format|
      format.js { render action: 'list' }
    end
  end

  def list_pending
    @tasks = current_user.pending_tasks
    respond_to do |format|
      format.js { render action: 'list' }
    end
  end

  def list_done
    @tasks = current_user.done_tasks
    respond_to do |format|
      format.js { render action: 'list' }
    end
  end

  def list_overdue
    @tasks = current_user.overdue_tasks
    respond_to do |format|
      format.js { render action: 'list' }
    end
  end

  def toggle_done
    @task = Task.find(params[:id])
    @task.toggle_done!
    load_tasks_count
    respond_to do |format|
      format.js
    end
  end


  private

  def task_params
    params.require(:task).permit(:name, :due_in)
  end

end
