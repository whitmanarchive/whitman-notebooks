class TeiToEs

  ################
  #    XPATHS    #
  ################

  # in the below example, the xpath for "person" is altered
  def override_xpaths
    xpaths = {}
    xpaths["format"] = "/TEI/text/@type"
    xpaths["rights_holder"] = "///fileDesc/publicationStmt/distributor"
    xpaths["source"] = "//sourceDesc/bibl/note[@type='project']"
    xpaths["works"] = "//text//work/@ref"
    xpaths
  end

  # NOTE do not need following fields:
  # keywords
  # recipient
  # spatial fields
  # topics

  #################
  #    GENERAL    #
  #################

  # Add more fields
  #  make sure they follow the custom field naming conventions
  #  *_d, *_i, *_k, *_t
  def assemble_collection_specific
    # TODO custom field text_type_k
  end

  ################
  #    FIELDS    #
  ################

  # Overrides of default behavior
  # Please see docs/tei_to_es.rb for complete instructions and examples

  def category
    "manuscripts"
  end

  def language
    # TODO verify that none of these are primarily english
    "en"
  end

  def languages
    # TODO verify that none of these are multiple languages
    [ "en" ]
  end

  def person
    []
  end

  def publisher
    # blank
  end

  def source
    get_text(@xpaths["source"])
  end

  def subcategory
    "notebooks"
  end

  def uri
    "#{@options["site_url"]}/manuscripts/notebooks/transcriptions/#{@filename}.html"
  end

  def uri_data
    File.join(
      @options["data_base"],
      "data",
      @options["collection"],
      "source/tei",
      "#{@id}.xml"
    )
  end

  def uri_html
    # TODO until HTML is generated, leave nil
    nil
    # File.join(
    #   @options["data_base"],
    #   "data",
    #   @options["collection"],
    #   "output",
    #   @options["environment"],
    #   "html",
    #   "#{@id}.html"
    # )
  end

end
