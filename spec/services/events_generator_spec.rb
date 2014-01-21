require 'spec_helper'

describe EventsGenerator do
  let(:timetable) do
    FactoryGirl.create(:timetable)
  end

  describe "study times" do
    before do
      ::EventsService::EventsGenerator.new(timetable)
    end
    it "should be normalized" do
      expect(timetable.study_times.length).to eq 10
    end
  end

end

