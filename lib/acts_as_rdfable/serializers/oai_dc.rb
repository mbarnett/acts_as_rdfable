class OaiDc
  ActsAsRdfable::Serializer.register_serializer format: :oai_dc, serializer: self

  def self.serialize(object, xml:)
    xml.tag!('oai_dc:dc', 'xmlns:oai_dc': 'http://www.openarchives.org/OAI/2.0/oai_dc/',
             'xmlns:dc':'http://purl.org/dc/elements/1.1/',
             'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
             'xsi:schemaLocation': 'http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd') do |oai|
      oai.dc(:title, object.title) if object.title.present?
      object.creator.each {|c| oai.dc :creator, c} if object.creator.present?
      object.contributor.each {|c| oai.dc :contributor, c} if object.contributor.present?
      oai.dc(:rights, object.rights) if object.rights.present?
      oai.dc(:date, object.date) if object.date.present?
      oai.dc(:publisher, object.publisher) if object.publisher.present?
      object.identifiers.each {|i| oai.dc :identifier, i} if object.identifiers.present?
      object.subject.each {|s| oai.dc :subject, s} if object.subject.present?
      oai.dc(:description, object.description) if object.description.present?
      oai.dc(:type, object.type) if object.type.present?
      object.languages.each {|l| oai.dc(:language, l) } if object.languages.present?
    end
  end
end
