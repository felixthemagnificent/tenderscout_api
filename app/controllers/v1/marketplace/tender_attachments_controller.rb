class V1::Marketplace::TenderAttachmentsController < ApplicationController
  before_action :set_tender
  before_action :set_attachment, only: [:destroy]

  def index
    render json: @tender.attachments, status: :ok
  end

  def create
    result = CreateTenderAttachment.call(params: attachment_params, tender: @tender)
    if result.success?
      render json: result.tender.attachments, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  def destroy
    @tender.attachments.delete(@attachment)
    @attachment.remove_file!
    @attachment.destroy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_tender
    @tender = Core::Tender.find(params[:tender_id])
  end

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def paginate_params
    params.permit(:page, :page_size)
  end

  # Only allow a trusted parameter "white list" through.
  def attachment_params
    params.permit(files: [])
  end
end
