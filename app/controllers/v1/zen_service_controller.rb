class V1::ZenServiceController < ApplicationController
  def create_ticket()
    check_valid_params
    params = ticket_params
    begin
      ticket = ZendeskAPI::Ticket.new($client, subject: params["subject"],
                                      comment: { value: params["comment_value"] },
                                      requester: {name: current_user.profiles.first.fullname ,
                                                     email: current_user.email },
                                      priority: "urgent")
      ticket.save!
    rescue ZendeskAPI::Error::RecordInvalid => e
      render json: {
          error: e.to_s
      }
    end
  end

  private

  def check_valid_params
    return render json: { error: 'Must have a comment' } unless params[:comment_value]
    return render json: { error: 'Must have a question title' } unless params[:subject]
  end

  def ticket_params
    params.permit(
        :subject,:comment_value, :requester,:name
    )
  end


end