class Lecture < CouchRest::Model::Base

	property :name, String
	collection_of :notes, :className => "Note"

end
