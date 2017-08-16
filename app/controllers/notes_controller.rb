class NotesController < ApplicationController

  def index
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      render json: @note, status: 201
    end
  end

  private

  def note_params
    params.require(:note).permit(:text, :client_id)
  end

end
