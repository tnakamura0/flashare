class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.boolean :correct
      t.references :card, null: false, foreign_key: true
      t.references :quiz_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
