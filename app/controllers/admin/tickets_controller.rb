module Admin
  class TicketsController < ApplicationController
    before_action :set_ticket, except: %i[index]

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

    def start
      @ticket.start!

      redirect_to admin_tickets_path, notice: "Ticket was successfully updated."
    rescue AASM::InvalidTransition => error
      redirect_to admin_tickets_path, alert: error.message
    end

    def resolve
      @ticket.resolve!

      redirect_to admin_tickets_path, notice: "Ticket was successfully updated."
    rescue AASM::InvalidTransition => error
      redirect_to admin_tickets_path, alert: error.message
    end

    def destroy
      @ticket.destroy!

      redirect_to admin_tickets_path, notice: "Ticket was successfully destroyed."
    end

    private

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def update_params
      params.require(:ticket).permit(:status)
    end

    def search_params
      params.permit(:query, :status)
    end
  end
end
