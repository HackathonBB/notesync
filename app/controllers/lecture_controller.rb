require 'Time'

class LectureController < ApplicationController

  before_filter :require_login

  def create
    newLecture = Lecture.new
    newLecture.name = params[:lecture][:name]
    newLecture.users << @user
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
    lecture = Lecture.get(params[:id])
    logger.debug(lecture.inspect)
    if lecture && lecture.notes.length > 0
      @mine = lecture.notes[0]
      @others = lecture.notes.reduce({}).reduce do |acc, n|
          acc[n.id] = n.id
        end 
    end
  end
  
  def delete
  end
end
