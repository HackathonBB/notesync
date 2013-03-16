class Paragraph < CouchRest::Model::Base
	property :timestamp, Time
	property :text, String
end
