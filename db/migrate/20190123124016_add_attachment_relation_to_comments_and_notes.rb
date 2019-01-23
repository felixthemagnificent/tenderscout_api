class AddAttachmentRelationToCommentsAndNotes < ActiveRecord::Migration[5.1]
  def change
  	create_table :attachments_comment, id: false, force: :cascade do |t|
      t.references :attachment, foreign_key: true
      t.references :comment, foreign_key: true
    end

     create_table :attachments_note, id: false, force: :cascade do |t|
      t.references :attachment, foreign_key: true
      t.references :note, foreign_key: true
    end
  end
end
