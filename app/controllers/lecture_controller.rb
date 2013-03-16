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
    name =  self.id + "_photo." + upload.original_filename.split(".").last
    directory = "public/images/products"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload.read) }
    self.photo = File.join("/images/products", name);

  end

  def addNote
    if @lecture.notes.any? { |n| n.user == @user }
      flash[:error] = "You can only have one note"
      redirect_to lecture_edit_path(@lecture)
      return
    end
    note = Note.new
    note.name = @user.nick
    note.user = @user
    note.lecture = @lecture
    note.save
    @lecture.notes << note
    @lecture.save
    redirect_to note_edit_path(note)
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
