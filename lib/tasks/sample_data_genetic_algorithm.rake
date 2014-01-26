namespace :db do
  desc "Fill database with sample data for testing the genetic algorithm"
  namespace :populate do
    task algorithm: :environment do
      ActiveRecord::Base.establish_connection "algorithm"

      user = make_user

      make_subjects(user)
      make_subject_groups(user)
      make_study_sources(user)
      make_subjects_study_sources(user)

      timetable = make_timetable(user)

      make_study_times(timetable)
    end

  end

end

def make_user
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(email: email,
               name: name,
               password: password,
               password_confirmation: password,
               confirmed_at: Time.now)
end

def make_subject_groups(user)
  sg_subjects = user.subjects.in_groups(5, false) #5 groups

  sg_subjects.each do | subjects|
    sg = SubjectGroup.create!(
      name: Faker::Name.name,
      user_id: user.id
    )

    sg.subjects << subjects
  end
end

def make_subjects(user)
  30.times do 
    name = Faker::Lorem.sentence(5)
    difficulty = rand(1..5)
    importance = rand(1..5)
    Subject.create!(creator_id: user.id, name: name, difficulty: difficulty, importance: importance )
  end
end

def make_study_sources(user)
  50.times do
    type = rand(1..3)
    title = Faker::Lorem.sentence(5)
    author = Faker::Lorem.sentence(5)
    StudySource.create!(creator_id: user.id, type: type, title: title, author: author)
  end
end

def make_subjects_study_sources(user)
  user.subjects.each do |s|
    s.study_sources << user.study_sources
  end
end

def make_timetable(user)
  t = Timetable.create!(
    goal: 'goal',
    creator_id: user.id,
    block_interval: Time.current.utc.beginning_of_day + 10.minutes,
    block_size: Time.current.utc.beginning_of_day + 50.minutes
  )
  t.build_calendar
  t
end

def make_study_times(timetable)

  t = Time.current.midnight

  #7 days
  7.times do |d|
    14.times do |i|
      StudyTime.create!(
        day: d+1,
        from: t + i.hours,
        to: t + (i+1).hours,
        productivity: rand(1..5),
        timetable_id: timetable.id
      )
    end
  end

end
