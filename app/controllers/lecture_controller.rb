require 'Time'

class LectureController < ApplicationController
  def create
    @note = Note.new
    @note.name = "aaa"
    @note.save

    redirect_to lecture_edit_path(@note)
  end

  def edit
    @note = Note.find(params[:note])
    logger.debug(params[:note])
    logger.debug(@note.inspect)
   
    if !@note
      redirect_to lecture_create_path()
    end
  end

  def list

    @lectures = Lecture.all;

  end

  def addParagraph
    note = Note.get(params[:id])

    if note
      p = Paragraph.new
      p.timestamp = Time.parse(params[:paragraph]["timestamp"])
      p.text = params[:paragraph]["text"]
      p.save
      note.paragraphs << p
      note.save
    end
  end

  def view
    note = Note.get(params[:id])

    if note
      @mine = note
      @others = Note.all
    end
  end

  def delete
  end
end
