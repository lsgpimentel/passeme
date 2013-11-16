FactoryGirl.define do

  factory :task do
    name "Bla bla bla"
    user
  end

  factory :user do
    sequence(:email) { |n| "email_#{n}@example.com"} 
    password 'changeme'
    password_confirmation 'changeme'
    #For Devise Confirmable
    confirmed_at Time.now

    factory :user_with_tasks do
      after(:create) do |user|
        FactoryGirl.create_list(:task, 5, user: user)
        FactoryGirl.create_list(:task, 5, done: true, user: user)
        FactoryGirl.create_list(:task, 5, due_in: rand(2.months).from_now, user: user)
      end
    end
  end

  factory :syllabus do

  end

  factory :timetable do

  end

  factory :subject do

  end

  factory :study_source do

  end

end
