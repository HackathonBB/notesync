class NoteController < ApplicationController
  def edit
  	@note = Note.find(params[:note])
   
    if !@note
      redirect_to lecture_create_path()
    end
  end

  def view
  	@note = Note.find(params[:note])
  end

  def json
    note = Note.get(params[:note])
    render :json => note
  end

  def addParagraph
  	note = Note.get(params[:id])

    if note
      p = Paragraph.new
      p.timestamp = Time.parse(params[:paragraph]["timestamp"]) + 60 * 60
      p.text = params[:paragraph]["text"]
      p.save
      note.paragraphs << p
      note.save
    end
  end

  def delete
  end
end
