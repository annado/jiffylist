# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_jiffy_session',
  :secret      => '027c803a7d1aa26f304d73eee0e7020b4dcb5d1b15046ffd9fe6e77298c526159b1a7aa8b6a005aac13597d25987ad88b185cb48e92b0941ca4b145663e911ad'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
