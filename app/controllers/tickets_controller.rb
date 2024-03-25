class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
  end

  def create
    result = Tickets::StoreToCsv.execute(params: create_params)

    if result.success?
      redirect_to tickets_path, notice: "Ticket was successfully created."
    else
      render :new, status: :unprocessable_entity, assigns: { ticket: result.ticket }
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def index
    search_result = Tickets::Search.execute(params: search_params)
    statistic_result = Tickets::CalculateStatistics.execute

    render :index, assigns: {
      tickets: search_result.tickets,
      query: search_result.query,
      status: search_result.status,
      statistic: statistic_result.statistics
    }
  end

  private

  def create_params
    params.require(:ticket).permit(:name, :email, :subject, :content)
  end

  def search_params
    params.permit(:query, :status)
  end
end
