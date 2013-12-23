require 'spec_helper'

describe StudyTime do
  let(:timetable) { FactoryGirl.create(:timetable) }

  describe "interval" do
    describe "is bigger than the time slot" do
      before do
        @study_time = StudyTime.new(from: Time.current, to: Time.current, productivity: 1, timetable: timetable, interval: Time.current.midnight + 10.minutes)
      end

      subject { @study_time }
      it { should_not be_valid } 

    end

    describe "is smaller than the time slot" do
      before do
        @study_time = StudyTime.new(from: Time.current, to: Time.current + 50.minutes, productivity: 1, timetable: timetable, interval: Time.current.midnight + 10.minutes)
      end

      subject { @study_time }
      it { should be_valid } 
    end
  end


  describe "when study times are not properly arranged" do
    let(:study_times) { FactoryGirl.create(:study_times) }

  end

end
