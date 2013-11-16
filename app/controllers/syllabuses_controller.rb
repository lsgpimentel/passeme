class SyllabusesController < AuthenticatedController

  add_breadcrumb "Syllabuses", :syllabuses_path

  def index
    @syllabuses = current_user.syllabuses
  end

  def create
    @syllabus = current_user.syllabuses.build(syllabus_params)
    if @syllabus.save!
    else
      #TODO error
      #render :index
    end
  end

  def show

  end

  def new
    @syllabus = Syllabus.new
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def syllabus_params
    params.require(:syllabus).permit(:name, :goal, :specific)
  end

end
