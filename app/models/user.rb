# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  locale                 :string(255)      default("pt-BR")
#  name                   :string(255)
#  time_zone              :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :async,
    :validatable, :confirmable,# :lockable,
    :omniauthable, omniauth_providers: [:google_oauth2]
  #, omniauthable_providers: [:facebook] -> tomando erro


  scope :to_ask_for_evaluation, -> { joins(:timetables).where('timetables.created_at BETWEEN ? AND ?', DateTime.current-2.weeks-1.day, DateTime.current-2.weeks ).distinct }

  before_create { email.downcase! }
  after_create :build_default_notification_settings

  validates :name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  has_many :tasks, dependent: :destroy

  has_many :timetables, dependent: :destroy, foreign_key: "creator_id"
  has_and_belongs_to_many :others_timetables_that_can_view, class_name: "Timetable", join_table: :users_view_timetables, autosave: true
  #has_many :created_groups, class_name: "Group"
  #has_and_belongs_to_many :groups, class_name: "Group"
  #want to receive group invitations?
  
  has_many :notifications

  has_one :setting

  has_many :subjects, dependent: :destroy, foreign_key: "creator_id"
  has_many :subject_groups, dependent: :destroy
  has_many :study_sources, dependent: :destroy, foreign_key: "creator_id"

  #include Notifiable

  ####
  #Google OAuth2 callback after authentication
  ####
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(name: data["name"],
                         email: data["email"],
                         password: Devise.friendly_token[0,20]
                        )
    end

    return user
  end



  ########
  #Tasks
  ########

  def pending_tasks
    tasks.where(done: false)
  end

  def done_tasks
    tasks.where(done: true)
  end

  def overdue_tasks
    tasks.where("due_in < ? AND done = ?", Date.today, false)
  end

  ##########
  #Timetables
  ##########

  #Can the user view the syllabus if he didn't created it?
  def can_view?(timetable)
    can_see = timetable.public? #Yes, if it's public
    can_see ||= others_timetables_that_can_view.include?(timetable) #Yes, if the user have explicit permission to do so
  end

  ########
  #Groups
  ########

  ##############
  #Notifications
  ##############
  def unread_notifications
    notifications.where(is_read: false).sent_to(:site)
  end

  def get_notification_setting(type)
    type_enum = NotificationSetting.type.values.find { |i| i == type.to_s }
    self.setting.notification_settings.find_by_type(type_enum.value)
  end

  def can_receive_email_for(type)
    setting = get_notification_setting(type)
    setting && setting.send_to_email?
  end

  private

  def build_default_notification_settings
    self.build_setting
    NotificationSetting.new_user_default_notification_settings.each do |k, v|

      if v.present?
        n = NotificationSetting.new(type: k)
        v.each do |s|
          n.send("send_to_#{s}=".to_sym, true)
        end
        self.setting.notification_settings << n
      end
    end
    self.setting.save!
  end

end
