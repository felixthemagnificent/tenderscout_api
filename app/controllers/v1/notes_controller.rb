class V1::NotesController < ApplicationController
  before_action :set_note, only: [:update, :destroy]

  NOTES_MODEL= {
      'tender_task' => 'Marketplace::TenderTask',
      'award_criterium' => 'Marketplace::TenderAwardCriterium',
      'bnb_question' => 'Marketplace::BidNoBidQuestion'
  }


  def create
    if NOTES_MODEL.key?(params[:notable_type])
      coment_model = NOTES_MODEL[params[:notable_type]]
    else
      render json: {error: 'Unvalid commentable type'}
      return false
    end
    @note = Note.new(note_params)
    @note.notable_type = coment_model
    @note.user_id = current_user.id
    if @note.save
      render json: @note, status: :created
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.permit(:body, :notable_id, :notable_type )
  end

end