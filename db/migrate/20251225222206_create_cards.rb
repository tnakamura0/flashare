class CreateCards < ActiveRecord::Migration[7.2]
  def change
    create_table :cards do |t|
      t.string :name, null: false
      t.text :meaning, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
