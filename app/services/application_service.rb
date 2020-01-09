require 'rest-client'
require 'json'

class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
