class CreateQuizSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :quiz_sessions do |t|
      t.integer :current_question_index, default: 0
      t.integer :total_questions
      t.integer :status, default: 0, null: false
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
