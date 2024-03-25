module Admin
  class CommentsController < ApplicationController
    before_action :set_ticket, only: %i[new create]

    def new
      @comment = @ticket.comments.new
    end

    def create
      @comment = @ticket.comments.new(create_params)

      if @comment.save
        redirect_to admin_tickets_path, notice: "Comment was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def create_params
      params.require(:comment).permit(:content)
    end
  end
end
