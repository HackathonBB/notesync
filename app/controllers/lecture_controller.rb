class LectureController < ApplicationController
  def create
    session[:note] = Note.new("aaa")
    redirect_to lecture_edit_path()
  end

  def edit
    @note = session[:note]
    if !@note
      redirect_to lecture_create_path()
    end
  end

  def addParagraph
  end

  def view
  end

  def delete
  end
end
