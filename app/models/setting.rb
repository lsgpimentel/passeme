# == Schema Information
#
# Table name: settings
#
#  id      :integer          not null, primary key
#  user_id :integer          not null
#

class Setting < ActiveRecord::Base
  has_many :notification_settings

  belongs_to :user

  accepts_nested_attributes_for :notification_settings

  validates :user, presence: true

  def toggle_make_tour_on_login!
    self.toggle!(:make_tour_on_login)
  end

  private

  def check_user_is_owner
    @task = current_user.tasks.find_by_id(params[:id])
    if @task.nil?
      redirect_to tasks_path
    end
  end

end
