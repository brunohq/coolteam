class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :email
      t.string :unique_token

      t.timestamps
    end
  end
end
