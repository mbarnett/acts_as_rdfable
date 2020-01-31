class OaiDc
  ActsAsRdfable::Serializer.register_serializer format: :oai_dc, serializer: self

  def self.serialize(object, xml:)

    xml.tag!('oai_dc:dc') do |oai|
      oai.dc :title, object.title
      object.creator.each {|c| oai.dc :creator, c}
      object.contributor.each {|c| oai.dc :contributor, c}
      oai.dc :rights, object.rights
      oai.dc :date, object.date
      oai.dc :publisher, object.publisher
      object.identifier.each {|i| oai.dc :identifier, i}
      object.subject.each {|s| oai.dc :subject, s}
      oai.dc :description, object.description
    end
  end
end
