require 'Time'

class LectureController < ApplicationController

  before_filter :require_login
  before_filter :get_lecture, :except => [:create, :new, :list]

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
    if not @lecture.users.include? @user
      @lecture.users << @user
      @lecture.save
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

  def addUser
    user = User.by_nick.key(params[:user][:nick]).first
    if user and not @lecture.users.include?(user)
      @lecture.users << user
      @lecture.save
    else
      if user != nil
        flash[:error] = "User alredy in lecture."
      else
        flash[:error] = "User doesnt exist"
      end
    end
    redirect_to lecture_edit_path(@lecture)
  end

  def addDocument
  end
  
  def delete
  end

  private

  def get_lecture
    @lecture = Lecture.find(params[:id])
    if !@lecture
      redirect_to lecture_new_path()
      return
    end
  end

end
