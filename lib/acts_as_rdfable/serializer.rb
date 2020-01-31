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

    def self.presenter_for(instance, format)
      @presenter_cache ||= {}
      @presenter_cache[instance] ||= begin
        klass_name = "Metadata::#{format.to_s.classify}::#{instance.class}Decorator"
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
