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

  def show
    @ticket = Ticket.find_by(barcode: params[:id])
    @ticket ||= Ticket.find_by(id: params[:id])
    if @ticket
      render json: @ticket.calc_ticket_price
    else
      render json: {error: 'Unable to find ticket with specified barcode or id'}
    end
  end
end
