class ApplicationController < ActionController::API
  def free_spaces
    render json: Ticket.free_spaces
  end
end
