require_relative "../../../whitman-scripts/scripts/ruby/get_works_info.rb"
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
    "Literary Manuscripts"
  end

  def date(before=true)
    if get_list(@xpaths["date"])
      datestr = get_list(@xpaths["date"]).first
    else
      datestr = nil
    end
    if get_text(@xpaths["date_not_after"])
      date_not_after
    elsif datestr && !datestr.empty?
      Datura::Helpers.date_standardize(datestr, false)
    end
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

  def category2
    "Literary Manuscripts / Notebooks"
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
    File.join(
      @options["data_base"],
      "data",
      @options["collection"],
      "output",
      @options["environment"],
      "html",
      "#{@id}.html"
    )
  end

  def citation
    # WorksInfo is get_works_info.rb in whitman-scripts repo
    @works_info = WorksInfo.new(xml, @id, @options["threads"])
    ids, names = @works_info.get_works_info
    citations = []
    if ids && ids.length > 0
      ids.each_with_index do |id, idx|
        name = names[idx]
        if !name
          puts "#{self.get_id} has bad work ids"
          puts "work id #{id} is missing a name"
        end
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
