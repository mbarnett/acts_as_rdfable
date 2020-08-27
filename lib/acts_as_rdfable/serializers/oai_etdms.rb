class OaiEtdms
  ActsAsRdfable::Serializer.register_serializer format: :oai_etdms, serializer: self

  def self.serialize(object, xml:)
    xml.tag!('etd_ms:thesis', 'xmlns:etd_ms': 'http://www.ndltd.org/standards/metadata/etdms/1.0/',
             'xmlns:xsi2': 'http://www.w3.org/2001/XMLSchema-instance',
             'xsi2:schemaLocation': 'http://www.ndltd.org/standards/metadata/etdms/1.0/ http://www.ndltd.org/standards/metadata/etdms/1-0/etdms.xsd') do |oai|

      oai.etd_ms(:title, object.title)
      oai.etd_ms(:creator, object.creator)
      object.subject.each {|s| oai.etd_ms :subject, s} if object.subject.present?
      oai.etd_ms(:description, object.description) if object.description.present?
      object.contributor.each {|c| oai.etd_ms :contributor, c, role: 'advisor'} if object.contributor.present?
      oai.etd_ms(:date, object.date)
      oai.etd_ms(:type, object.type) if object.type.present?
      object.identifiers.each {|i| oai.etd_ms :identifier, i}
      oai.etd_ms(:language, object.language)  if object.language.present?
      oai.etd_ms(:rights, object.rights) if object.rights.present?

    oai.etd_ms(:degree) do |degree|
      degree.etd_ms(:name, object.degree_name)
      degree.etd_ms(:level, object.degree_level) if object.degree_level.present?
      degree.etd_ms(:discipline, object.discipline) if object.discipline.present?
      degree.etd_ms(:grantor, object.institution)
      degree.etd_ms(:publisher, object.publisher)
    end
    end
  end
end
