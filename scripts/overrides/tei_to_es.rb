require_relative "../../../whitman-scripts/scripts/ruby/get_works_info.rb"
class TeiToEs

  ################
  #    XPATHS    #
  ################

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
    "In Whitman's Hand"
  end

  def category2
    "In Whitman's Hand / Notebooks"
  end

  def language
    # TODO verify that none of these are primarily english
    "en"
  end

  # def languages
  #   # TODO verify that none of these are multiple languages
  #   [ "en" ]
  # end

  def person
    []
  end

  def publisher
    # blank
  end

  def source
    get_text(@xpaths["source"])
  end

  def uri
    "#{@options["site_url"]}/item/#{@filename}.html"
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

  def citation
    # WorksInfo is get_works_info.rb in whitman-scripts repo
    @works_info = WorksInfo.new(xml)
    ids, names = @works_info.get_works_info
    citations = []
    if ids && ids.length > 0
      ids.each_with_index do |id, idx|
        name = names[idx]
        citations << {
          "id" => id,
          "title" => name,
          "role" => "whitman_id"
        }
      end
    end
    citations
  end

end
