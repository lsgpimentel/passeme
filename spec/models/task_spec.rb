# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  done       :boolean
#  due_in     :date
#  user_id    :integer
#

require 'spec_helper'

describe Task do

  let(:user) { FactoryGirl.create(:user) }
  before { @task = Task.new(name: 'Test Task', created_at: Time.now, user_id: user.id) }

  subject { @task }

  it { should respond_to(:name) }
  it { should respond_to(:created_at) }
  it { should respond_to(:done) }
  it { should respond_to(:due_in) }
  it { should respond_to(:user_id) }

  describe "when user_id is not present" do
    before { @task.user_id = nil }
    it { should_not be_valid }
  end

  describe "when name is blank" do
    before { @task.name = "     "}
    it { should_not be_valid }
  end

  describe "when due date is set before today" do
    before { @task.due_in = Date.yesterday }
    it { should_not be_valid }
  end

end
