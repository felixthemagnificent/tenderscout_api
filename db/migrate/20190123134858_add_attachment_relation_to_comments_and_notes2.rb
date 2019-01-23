class AddAttachmentRelationToCommentsAndNotes2 < ActiveRecord::Migration[5.1]
  def change
  	create_table :attachments_comments, id: false, force: :cascade do |t|
      t.references :attachment, foreign_key: true
      t.references :comment, foreign_key: true
    end

    create_table :attachments_notes, id: false, force: :cascade do |t|
      t.references :attachment, foreign_key: true
      t.references :note, foreign_key: true
    end
  end
end
