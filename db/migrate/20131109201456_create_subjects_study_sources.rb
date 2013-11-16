class CreateSubjectsStudySources < ActiveRecord::Migration
  def change
    create_table :subjects_study_sources, id: false do |t|
      t.belongs_to :subject, null: false
      t.belongs_to :study_source, null: false
    end

    add_index(:subjects_study_sources, [:subject_id, :study_source_id], :unique => true)
  end
end
