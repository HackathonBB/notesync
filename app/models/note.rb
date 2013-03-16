class Note < CouchRest::Model::Base

	property :name, String, :default => ""
	collection_of :paragraphs, :className => "Paragraph"

end
