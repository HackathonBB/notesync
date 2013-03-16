require 'Time'

class LectureController < ApplicationController
  def create
    newLecture = Lecture.new
    newLecture.name = params[:lecture][:name]
    newLecture.save
    redirect_to lecture_edit_path(newLecture)
  end

  def new
  end

  def edit
    @lecture = Lecture.find(params[:id])
    if !@lecture
      redirect_to lecture_new_path()
      return
    end
  end

  def list

    @lectures = Lecture.all;

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
