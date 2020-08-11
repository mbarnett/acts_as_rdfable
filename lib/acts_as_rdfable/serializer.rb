module ActsAsRdfable
  module Serializer
    def self.register_serializer(format:, serializer:)
      @serializers ||= {}

      @serializers[format] = serializer
    end

    def self.known_serializers
      @serializers || {}
    end

    def self.serializer_for(format)
      @serializers[format]
    end

    def self.register_format_for_class(klass, format:)
      format = format.to_sym if format.is_a?(String)

      classes_for_format[format] ||= []
      classes_for_format[format] << klass
    end

    def self.classes_for_format
      @registered_class_formats ||= {}
    end

    def self.serializable_classes_for_format(format)
      format = format.to_sym if format.is_a?(String)
      classes_for_format[format] || []
    end

    def self.presenter_for(instance, format)
      @presenter_cache ||= {}
      @presenter_cache[instance] ||= begin
        klass_name = "Metadata::#{format.to_s.camelize}::#{instance.class}Decorator"
        klass = klass_name.constantize
        klass.decorate(instance)
      rescue NameError
        raise NoSuchPresenter, "Metadata Decorator #{klass_name} is not defined for #{instance}"
      end
    end

    def self.serialize(instance:, format:, xml_doc: )
      serializer = self.serializer_for(format)
      presenter = self.presenter_for(instance, format)
      serializer.serialize(presenter, xml: xml_doc)
    end
  end
end
