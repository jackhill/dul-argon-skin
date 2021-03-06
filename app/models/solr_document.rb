# frozen_string_literal: true

require 'trln_argon'

class SolrDocument
  include Blacklight::Solr::Document

  # This is needed so that SolrDocument.find will work correctly
  # from the Rails console with our Solr configuration.
  # Otherwise, it tries to use the non-existent document request handler.
  SolrDocument.repository.blacklight_config.document_solr_path = :document
  SolrDocument.repository.blacklight_config.document_solr_request_handler = nil
  SolrDocument.use_extension(TrlnArgon::DocumentExtensions::Ris)
  SolrDocument.use_extension(TrlnArgon::DocumentExtensions::OpenurlCtxKev)


  include TrlnArgon::SolrDocument

  include TrlnArgon::ItemDeserializer



  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(TrlnArgon::DocumentExtensions::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(TrlnArgon::DocumentExtensions::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)
end
