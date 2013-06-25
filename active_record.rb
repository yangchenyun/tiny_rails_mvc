require_relative 'connection_adapter'

module ActiveRecord
  class Base
    @@connection_adapter = SQLiteAdapter.new

    class << self
      def find(id)
        new(@@connection_adapter.find(model_name, id))
      end

      def find_all
        @@connection_adapter.find_all(model_name).map do |row|
          new(row)
        end
      end

      def model_name
        name.downcase + 's'
      end
    end

    def initialize(attrs)
      @attrs = attrs
    end

    def method_missing(method_name, *args)
      if @attrs.keys.include?(method_name.to_s)
        @attrs[method_name.to_s]
      else
        super
      end
    end
  end
end
