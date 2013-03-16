class ParagraphController < ApplicationController
  def modify
  end

  def addLink
  end

  def delete
  end

  def between
  	lecture = Lecture.get(params[:lecture])
  	timeA = Time.at(params[:a].to_i)
  	timeB = Time.at(params[:b].to_i)

  	if lecture
  		notes = lecture.notes.reduce [] { |acc, x| x.paragraphs.each { |e| acc << [x.user.nick, e.text[0..50]] if e.timestamp <= timeB && e.timestamp >= timeA }; acc }
  		render :json => notes
  	end
  end

  def get
  end
end
