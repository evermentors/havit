class AddQuestionLeadingToRapidfireQuestions < ActiveRecord::Migration
  def change
    add_column :rapidfire_questions, :question_leading, :string
  end
end
