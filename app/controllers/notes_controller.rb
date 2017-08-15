class NotesController < ApplicationController

  def index
  end

  def create
    @note = note.new(note_params)
    if @note.save
      render json: @note
    end
  end

end
