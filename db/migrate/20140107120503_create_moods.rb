class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|
      t.string :rating
      t.date :date
      t.text :comment
      t.references :collaborator

      t.timestamps
    end
    add_index :moods, :collaborator_id
  end
end
