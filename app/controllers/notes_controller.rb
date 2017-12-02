class NotesController < ApplicationController

  # Render notes onto page via AJAX
  def index
  end

  # Submission of new note form
  def create
    @note = Note.new(note_params)
    if @note.save
      render json: @note, status: 201
    end
  end

  # Destroy notes
  def destroy
    @client = Client.find_by(id: params[:client_id])
    @client.notes.destroy_all
  end

  private

  def note_params
    params.require(:note).permit(:text, :client_id)
  end

end
