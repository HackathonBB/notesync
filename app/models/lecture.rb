class Lecture < CouchRest::Model::Base

	property :name, String
	collection_of :notes, :className => "Note"
	collection_of :users, :className => "User"

end
