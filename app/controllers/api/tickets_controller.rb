class Api::TicketsController < ApplicationController
  before_action :get_ticket, only: [:show, :payments, :state]

  def create
    @ticket = Ticket.new
    if @ticket.is_space_available? && @ticket.save
      render json: @ticket
    else
      render json: {error: @ticket.errors.full_messages.join(',')}
    end
  end

  def show
    if @ticket
      render json: @ticket.calc_ticket_price
    else
      render json: {error: 'Unable to find ticket with specified barcode or id'}
    end
  end

  def payments
    @ticket.status = "paid"
    @ticket.payment_option = params[:payment_option]
    @ticket.payment_time = Time.now
    if @ticket.save
      render json: @ticket
    else
      render json: {error: 'Unable to make payment'}
    end
  end

  def state
    @ticket.exit_check
    render json: @ticket.status
  end

  private
  def get_ticket
    @ticket = Ticket.find_by(barcode: params[:id])
  end
end
