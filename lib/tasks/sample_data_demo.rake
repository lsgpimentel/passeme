namespace :db do
  desc "Fill database with sample data for demo user"
  namespace :populate do
    task demo: :environment do
      populate
    end

  end

end



def populate

  DatabaseDemoPopulation.new.populate

end

class DatabaseDemoPopulation
  def initialize
    delete_demo_user_if_exists
    @user = make_user
  end


  def data
    {
      study_sources: [
        {
          type: StudySource.type.find_value(:book).value,
          title: "Probabilidade: Um Curso Introdutório",
          author: "Carlos Alberto Barbosa Dantas"
        },
        {
          type: StudySource.type.find_value(:book).value,
          title: "Estatística Básica Simplificada",
          author: "SERGIO CARVALHO, WEBER CAMPOS"
        },
        {
          type: StudySource.type.find_value(:book).value,
          title: "Matematica Financeira Simplificada Para Concursos",
          author: "Weber Campos, Sergio Carvalho"
        },
        {
          type: StudySource.type.find_value(:book).value,
          title: "Curso de Álgebra Linear, Um Vol. 34",
          author: "FLAVIO ULHOA COELHO,MARY LILIAN LOURENÇO"
        },
        {
          type: StudySource.type.find_value(:book).value,
          title: "Concordância verbal",
          author: "Maria Aparecida Baccega"
        },
        {
          type: StudySource.type.find_value(:book).value,
          title: "Gramática em Exercícios",
          author: "Paiva; Marcelo"
        },
        {
          type: StudySource.type.find_value(:book).value,
          title: "O livro da semântica",
          author: "Walmirio Macedo"
        },
        {
          type: StudySource.type.find_value(:book).value,
          title: "Interpretaçao de Textos",
          author: "A. Oliveira Lima"
        },
        {
          type: StudySource.type.find_value(:book).value,
          title: "Direito Administrativo",
          author: "Elias Freire"
        },
        {
          type: StudySource.type.find_value(:book).value,
          title: "Direito Constitucional em Perguntas e Respostas",
          author: "MARCELO VICENTE DE ALKMIM PIMENTA"
        }
      ],
      groups: [
        {
          name: "Matemática",
          subjects: [
            {
              name: "Probabilidade",
              importance: 4,
              difficulty: 3,
              study_sources_titles: ["Probabilidade: Um Curso Introdutório"]
            },
            {
              name: "Estatística",
              importance: 4,
              difficulty: 4,
              study_sources_titles: ["Estatística Básica Simplificada"]
            },
            {
              name: "Matemática Financeira",
              importance: 4,
              difficulty: 2,
              study_sources_titles: ["Matematica Financeira Simplificada Para Concursos"]
            },
            {
              name: "Álgebra Linerar",
              importance: 1,
              difficulty: 4,
              study_sources_titles: ["Curso de Álgebra Linear, Um Vol. 34"]
            }
          ]
        },
        {
          name: "Português",
          subjects: [
            {
              name: "Concordância",
              importance: 2,
              difficulty: 4,
              study_sources_titles: ["Concordância verbal", "Gramática em Exercícios"]
            },
            {
              name: "Regência",
              importance: 5,
              difficulty: 1,
              study_sources_titles: ["Gramática em Exercícios", "O livro da semântica"]
            },
            {
              name: "Análise Sintática",
              importance: 1,
              difficulty: 5,
              study_sources_titles: ["Gramática em Exercícios", "Interpretaçao de Textos"]
            },
            {
              name:"Interpretação",
              importance: 4,
              difficulty: 5,
              study_sources_titles: ["Gramática em Exercícios", "Interpretaçao de Textos"]
            }
          ]

        },
        {
          name: "Direito",
          subjects: [
            {
              name: "Administrativo",
              importance: 5,
              difficulty: 5,
              study_sources_titles: ["Direito Administrativo"]
            },
            {
              name:"Constitucional",
              importance: 5,
              difficulty: 1,
              study_sources_titles: ["Direito Constitucional em Perguntas e Respostas"]
            }
          ]
        }
      ]
    }
  end

  def populate
    @user.transaction do

      make_study_sources
      data[:groups].each do |group_data|
        group = make_subject_group(group_data[:name])
        group_data[:subjects].each do |subject_data|
          subject = make_subject(group, subject_data)
          subject_data[:study_sources_titles].each do |study_source_data_title|
            associate_study_source_with_subject(subject, study_source_data_title)
          end
        end
      end

      t = make_timetable
      t.subjects = @user.subjects
      make_study_times(t, 10, 5)
      make_events(t)
      t.save!
    end
  end

  private

  def make_events(timetable)
    timetable.calendar.calendar_event_sources = ::EventsService::EventsGenerator.new(timetable).event_sources
  end


  def make_timetable
    t = Timetable.new(
      name: 'Grade de Teste',
      goal: 'Objetivo de Teste',
      creator_id: @user.id,
      block_interval: Time.current.utc.beginning_of_day + 10.minutes,
      block_size: Time.current.utc.beginning_of_day + 50.minutes,
      start_date: "15/09/2014",
      end_date: "15/09/2015",
      active: true
    )
    t.build_calendar
    t
  end

  def make_study_times(timetable, hours, days)

    t = Time.current.midnight

    #7 days
    days.times do |d|
      hours.times do |i|
        timetable.study_times << StudyTime.new(
          day: d+1,
          from: t + i.hours,
          to: t + (i+1).hours,
          productivity: rand(1..5)
        )
      end
    end

  end

  def delete_demo_user_if_exists
    u = User.find_by_email("demo@passeme.com")
    u.destroy! if u != nil
  end

  def make_user
    name = 'Usuário Demo PasseMe'
    email = 'demo@passeme.com'
    password = "demopasseme"
    User.create!(email: email,
                 name: name,
                 password: password,
                 password_confirmation: password,
                 confirmed_at: Time.now)
  end

  def make_subject_group(name)
    SubjectGroup.create!(user: @user, name: name)
  end

  def make_subject(group, subject_data)
    name = subject_data[:name]
    difficulty = subject_data[:difficulty]
    importance = subject_data[:importance]
    Subject.create!(creator_id: @user.id, name: name, difficulty: difficulty, importance: importance, subject_group: group )
  end

  def make_study_sources
    data[:study_sources].each do |data|
      type = data[:type]
      title = data[:title]
      author = data[:author]
      StudySource.create!(creator_id: @user.id, type: type, title: title, author: author)
    end
  end

  def associate_study_source_with_subject(subject, study_source_title)
    subject.study_sources << StudySource.find_by_title(study_source_title)
  end
end

