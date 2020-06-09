class TeiToEs

  ################
  #    XPATHS    #
  ################

  # in the below example, the xpath for "person" is altered
  def override_xpaths
    xpaths = {}
    xpaths["date"] = {
      "not_before" => "/TEI/teiHeader/fileDesc/sourceDesc/bibl/date/@notBefore",
      "not_after" => "/TEI/teiHeader/fileDesc/sourceDesc/bibl/date/@notAfter"
    }
    xpaths["format"] = "/TEI/text/@type"
    xpaths
  end

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

  def date(before=true)
    date_str = ""
    if before
      date_str = get_text(@xpaths["date"]["not_before"])
    else
      date_str = get_text(@xpaths["date"]["not_after"])
    end
    CommonXml.date_standardize(date_str, before)
  end

  def format
    get_text(@xpaths["format"])
  end

  def language
    # TODO verify that none of these are primarily english
    "en"
  end

  def languages
    # TODO verify that none of these are multiple languages
    [ "en" ]
  end

  # TODO place, publisher, rights, rights_uri, rights_holder, source

  def subcategory
    "notebooks"
  end

  # TODO text other from author, title, publisher, pubplace, and date[@when]

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
