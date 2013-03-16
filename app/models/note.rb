class Note < CouchRest::Model::Base

	property :name, String, :default => ""
	collection_of :paragraphs, :className => "Paragraph"
	belongs_to :user, :className => "User"
	belongs_to :lecture, :className => "Lecture"

end
