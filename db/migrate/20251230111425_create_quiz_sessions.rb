class CreateQuizSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :quiz_sessions do |t|
      t.integer :current_question_index
      t.integer :total_questions
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
