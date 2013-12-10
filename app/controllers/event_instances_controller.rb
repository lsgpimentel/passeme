class EventInstancesController < ApplicationController
  def index
    @event_instances = EventInstance.occurrences_between(Date.today - 1.year,Date.today + 1.year)
    respond_to do |format|
      format.html
      format.json { render json: @event_instances.to_json(:methods => [:color]) }
    end
  end
end
