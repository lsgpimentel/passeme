namespace :db do
  desc "Fill database with sample data"
  namespace :populate do
    task all: :environment do
      populate_all
    end

    task subjects: :environment do
      User.all.each do |u|
        make_subjects(u)
      end
    end
    task study_sources: :environment do
      User.all.each do |u|
        make_study_sources(u)
      end
    end
    task subjects_study_sources: :environment do
      make_subjects_study_sources
    end

    task generate_events: :environment do
      make_events
    end
  end

end

def populate_all
  10.times do

    user = make_user

    make_tasks(user)
    make_subjects(user)
    make_study_sources(user)

  end

  make_subjects_study_sources
end

def make_events
  t = Timetable.find_by_id(10)
  t.calendar.calendar_event_sources << EventsGenerator.new(t).event_sources
  t.save!

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

def make_tasks(user)
  10.times do 
    name = Faker::Lorem.sentence(5)
    due_in = rand(2.years).from_now
    Task.create!(user_id: user.id, name: name, due_in: due_in)
  end
end

def make_subjects(user)
  10.times do 
    name = Faker::Lorem.sentence(5)
    difficulty = rand(1..5)
    Subject.create!(creator_id: user.id, name: name, difficulty: difficulty)
  end
end

def make_study_sources(user)
  10.times do
    type = rand(1..3)
    title = Faker::Lorem.sentence(5)
    author = Faker::Lorem.sentence(5)
    StudySource.create!(creator_id: user.id, type: type, title: title, author: author)
  end
end

def make_subjects_study_sources 
  Subject.all.each do |s|
    s.study_sources << StudySource.all
  end
end
