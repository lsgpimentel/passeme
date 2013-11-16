class GroupsController < AuthenticatedController

  def index
    @groups = current_user.groups
  end

  def show

  end

  def create

  end
end
