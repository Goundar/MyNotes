class NotesController < ApplicationController

  def index
    @message = params[:message]
  end

end
