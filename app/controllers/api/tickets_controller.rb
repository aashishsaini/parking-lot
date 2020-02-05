class Api::TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
    render json: @tickets
  end

  def create
    @ticket = Ticket.new
    if @ticket.save
      render json: @ticket
    else
      render json: {error: @ticket.errors.full_messages.join(',')}
    end
  end
end
