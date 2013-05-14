class AhaService
  include Networking
  include Errors
  include Schema
  include Api
  include Documentation
  extend Schema::ClassMethods
  extend Documentation::ClassMethods
  
  # Public: Aha! API client for calling back into Aha!.
  #
  # Returns an AhaApi::Client.
  attr_reader :api
  
  # Public: Gets the configuration data for this Service instance.
  #
  # Returns a Hash.
  attr_reader :data
  
  # Public: Gets the unique payload data for this Service instance.
  #
  # Returns a Hash.
  attr_reader :payload

  # Public: Gets the identifier for the Service's event.
  #
  # Returns a Symbol.
  attr_reader :event
  
  attr_reader :event_method
  
  # Public: Gets the configuration data for this Service instance.
  #
  # Returns a Hash.
  attr_reader :data
  
  attr_reader :logger
  
  def initialize(event, data = {}, payload = nil)
    @event = event.to_sym
    @data = Hashie::Mash.new(data || {})
    @payload = Hashie::Mash.new(payload)
    @event_method = ["receive_#{event}", "receive_event"].detect do |method|
      respond_to?(method)
    end
    @api = @data.api_client || allocate_api_client
    @logger = @data.logger || allocate_logger
  end
  
  def self.default_http_options
    @@default_http_options ||= {
      :request => {:timeout => 10, :open_timeout => 5},
      :ssl => {:verify_depth => 5},
      :headers => {}
    }
  end
  
  def respond_to_event?
    !@event_method.nil?
  end
  
  def receive(timeout = nil)
    return unless respond_to_event?
    timeout_sec = (timeout || 20).to_i
    Timeout.timeout(timeout_sec, TimeoutError) do
      send(event_method)
    end
    self
  rescue AhaService::ConfigurationError, Errno::EHOSTUNREACH, Errno::ECONNRESET, SocketError, Net::ProtocolError => err
    if !err.is_a?(AhaService::Error)
      err = ConfigurationError.new(err)
    end
    raise err
  end
  
  class << self
    # Gets the official title of this Service.  This is used in any
    # user-facing documentation regarding the Service.
    #
    # Returns a String.
    def title(value = nil)
      if value
        @title = value
      else
        @title ||= begin
          hook = name.dup
          hook.sub! /.*:/, ''
          hook
        end
      end
    end

    # Sets the official title of this Service.
    #
    # title - The String title.
    #
    # Returns nothing.
    attr_writer :title

    # Gets the name that identifies this Service type.  This is a
    # short string that is used to uniquely identify the service internally.
    #
    # Returns a String.
    def service_name(value = nil)
      if value
        @service_name = value
      else
        @service_name ||= begin
          hook = name.dup
          hook.downcase!
          hook.sub! /.*:/, ''
          hook
        end
      end
    end
    
    attr_writer :service_name
  
  end
  
  def allocate_logger
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
    @logger
  end
end