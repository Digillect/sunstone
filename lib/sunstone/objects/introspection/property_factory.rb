module Sunstone
  module Objects
    module Introspection
      class PropertyFactory
        attr_reader :property

        def initialize(property)
          @property = property
        end

        def create_methods(target_klass)
          if property.scalar?
            if property.readonly?
              create_readonly_scalar_reader target_klass
            else
              create_scalar_reader target_klass
              create_scalar_writer target_klass
              create_boolean_bang_writer target_klass if property.boolean?
            end

            create_boolean_question_mark_reader target_klass if property.boolean?
          else
            create_complex_reader target_klass
          end
        end

        private

        def create_readonly_scalar_reader(target_klass)
          variable = property.variable

          target_klass.send :define_method, property.name do
            instance_variable_get variable
          end
        end

        def create_boolean_question_mark_reader(target_klass)
          variable = property.variable

          target_klass.send :define_method, "#{property.string_name}?" do
            value = instance_variable_get variable

            !!value
          end
        end

        def create_scalar_reader(target_klass)
          variable = property.variable

          target_klass.send :define_method, property.name do |value = nil|
            return instance_variable_get variable if value.nil?

            instance_variable_set variable, value
          end
        end

        def create_scalar_writer(target_klass)
          variable = property.variable

          target_klass.send :define_method, "#{property.string_name}=" do |value|
            instance_variable_set variable, value
          end
        end

        def create_boolean_bang_writer(target_klass)
          variable = property.variable

          target_klass.send :define_method, "#{property.string_name}!" do
            instance_variable_set variable, true
          end
        end

        def create_complex_reader(target_klass)
          variable = property.variable

          target_klass.send :define_method, property.name do |&block|
            value = instance_variable_get variable

            value.instance_eval(&block) unless block.nil?

            value
          end
        end
      end
    end
  end
end
