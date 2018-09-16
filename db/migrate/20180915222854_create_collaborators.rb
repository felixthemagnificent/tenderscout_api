class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.string :role
      t.references :user, foreign_key: true
      t.references :collaboration, foreign_key: true
      t.timestamps
    end
  end
end
