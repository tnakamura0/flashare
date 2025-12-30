class CreateDeckCards < ActiveRecord::Migration[7.2]
  def change
    create_table :deck_cards do |t|
      t.references :deck, foreign_key: true
      t.references :card, foreign_key: true

      t.timestamps
    end
    add_index :deck_cards, [ :deck_id, :card_id ], unique: true
  end
end
