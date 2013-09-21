namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end

def make_users
  50.times do
    name = Faker::Name.name
    email = Faker::Internet.email
    password = "password"
    user = User.create!(email: email,
                        password: password,
                        password_confirmation: password,
                        confirmed_at: Time.now)

    #Create Tasks
    20.times do 
      name = Faker::Lorem.sentence(5)
      due_in = rand(2.years).from_now
      Task.create!(user_id: user.id, name: name, due_in: due_in)
    end
  end

end

