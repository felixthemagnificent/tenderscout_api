class AddQuestionAndAnswerDateToTender < ActiveRecord::Migration[5.1]
  def change
    add_column :core_tenders, :questioning_dedline, :datetime
    add_column :core_tenders, :answering_dedline, :datetime
  end
end
