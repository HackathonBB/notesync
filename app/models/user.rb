class User < CouchRest::Model::Base

	property :nick, String
	property :password, String

	design do
		view :by_nick
	end

end
