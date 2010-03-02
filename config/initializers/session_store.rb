# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_scraperbuddy_session',
  :secret      => '359abeecafb102c187d63ca44914697798307f7749e744ce613596565478fa5b3b4551004e8b82886ffbd79523c68f08d50cfd6797d4cdd3933415daa9c8e30e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
