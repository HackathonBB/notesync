class Note < CouchRest::Model::Base

	property :name, String, :default => ""
	collection_of :paragraphs, :className => "Paragraph"

	def initialize(name)
		self.name = name
	end

end
