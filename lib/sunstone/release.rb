module Sunstone
  class Release
    attr_reader :objects

    def initialize
      @objects = []
      @scopes = []
      @preludes = Hash.new { |hash, key| hash[key] = [] }
      @resource_to_class = {}
      @class_to_resource = {}
    end

    def scope?
      @scopes.length.positive?
    end

    def scope(scope_name = nil, &block)
      return @scopes.last if scope_name.blank?

      @scopes.push scope_name.to_s

      instance_eval(&block) if block_given?

      @scopes.pop
    end

    def setup_resource(*resources, &block)
      resources.push Sunstone::Objects::KubernetesObject if resources.empty?

      resources.each do |resource|
        @preludes[resource_to_class(resource)].push block
      end
    end

    def define_helper(name, *resources, &block)
      extension = Module.new do
        define_method(name.to_sym, &block)
      end

      resources.each do |resource|
        resource_to_class(resource).include extension
      end
    end

    def resource_name(klass)
      @class_to_resource[klass]
    end

    def register_resource(resource, klass)
      resource = resource.to_sym

      @resource_to_class[resource] = klass
      @class_to_resource[klass] = resource

      extension = Module.new do
        define_method(resource) do |name = nil, *args, &block|
          object(name, klass, *args, &block)
        end
      end

      self.class.include extension
    end

    def register_custom_resource(resource, kind, api_version)
      resource = resource.to_sym

      raise "Custom resource #{resource.to_s} is already registered" if @resource_to_class.key? resource

      _kind = kind
      _api_version = api_version

      klass = Class.new Sunstone::Objects::CustomResource do
        define_method :kind do
          _kind
        end

        define_method :api_version do
          _api_version
        end
      end

      register_resource resource, klass
    end

    private

    def object(name, klass, *args, &block)
      if name.blank?
        error "Name for the #{klass.name} is not provided through the factory or scope" unless scope?

        name = scope
      else
        name = name.to_s
      end

      object = objects.find { |obj| obj.instance_of?(klass) && obj.metadata.name == name }

      unless object
        object = klass.new name, *args

        objects.push object

        run_preludes object
      end

      object.instance_eval(&block) if block_given?

      object
    end

    def run_preludes(object)
      object_class = object.class

      @preludes.each_pair do |klass, list|
        next unless object_class <= klass

        list.each do |prelude|
          prelude.call object
        end
      end
    end

    def resource_to_class(resource)
      if resource.is_a? Class
        return resource if resource <= Sunstone::Objects::KubernetesObject

        error 'Invalid Kubernetes resource'
      end

      error 'Kubernetes resource must be a Symbol or Class' unless resource.is_a? Symbol
      error "Kubernetes resource #{resource.to_s.classify} is not defined" unless @resource_to_class.key? resource

      @resource_to_class[resource]
    end

    def error(message, exit_code = 10)
      Sunstone.error("#{proper_location}: #{message}", exit_code)
    end

    def proper_location
      location = caller_locations.find { |l| l.absolute_path != __FILE__ }

      "#{location.absolute_path}:#{location.lineno}"
    end
  end
end
