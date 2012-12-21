require 'thread'

module Moneta
  # Locks the underlying stores with a Mutex
  # @api public
  class Lock < Wrapper
    # Constructor
    #
    # @param [Moneta store] adapter The underlying store
    # @param [Hash] options
    #
    # Options:
    # * :mutex - Mutex object (default Mutex.new)
    def initialize(adapter, options = {})
      super
      @lock = options[:mutex] || Mutex.new
    end

    protected

    def wrap(*args, &block)
      @lock.synchronize(&block)
    end
  end
end
