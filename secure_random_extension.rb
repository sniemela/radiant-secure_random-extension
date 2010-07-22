# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class SecureRandomExtension < Radiant::Extension
  version "1.0"
  description "Provides a tag which generates a random string or number with a given secure method."
  url "http://github.com/sniemela/radiant-secure_random-extension"
  
  # extension_config do |config|
  #   config.gem 'some-awesome-gem
  #   config.after_initialize do
  #     run_something
  #   end
  # end

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    Page.send(:include, SecureRandomTag)
  end
end
