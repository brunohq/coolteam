class AddGroupToCollaborator < ActiveRecord::Migration
  def self.up
    change_table :collaborators do |t|
      t.references :group
    end
  end

  def self.down
    change_table :collaborators do |t|
      t.references :group
    end
  end
end

