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
      resources.push Sunstone::Objects::KubernetesObject if resources.empty?

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
        define_method(resource) do |name = nil, &block|
          object(name, klass, &block)
        end
      end

      self.class.include extension
    end

    def register_custom_resource(resource, kind, api_version)
      resource = resource.to_sym

      raise "Custom resource #{resource} is already registered" if @resource_to_class.key? resource

      klass = Class.new Sunstone::Objects::CustomResource

      klass.instance_variable_set :@api_kind, kind
      klass.instance_variable_set :@api_group_and_version, api_version

      register_resource resource, klass
    end

    private

    def object(name, klass, &block)
      if name.blank?
        raise "Name for the #{klass.name} is not provided through the factory or scope" unless scope?

        name = scope
      else
        name = name.to_s
      end

      object = objects.find { |obj| obj.instance_of?(klass) && obj.metadata.name == name }

      unless object
        object = klass.new name

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

        raise 'Invalid Kubernetes resource'
      end

      raise 'Kubernetes resource must be a Symbol or Class' unless resource.is_a? Symbol
      raise "Kubernetes resource #{resource.to_s.classify} is not defined" unless @resource_to_class.key? resource

      @resource_to_class[resource]
    end
  end
end
