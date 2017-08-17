class NotesController < ApplicationController

  def index
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      render json: @note, status: 201
    end
  end

  def destroy
    @client = Client.find_by(id: params[:client_id])
    @client.notes.destroy_all
  end

  private

  def note_params
    params.require(:note).permit(:text, :client_id)
  end

end
