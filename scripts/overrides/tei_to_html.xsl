<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:whitman="http://www.whitmanarchive.org/namespace"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0"
  exclude-result-prefixes="xsl tei xs whitman">
  
  <!-- ==================================================================== -->
  <!--                             IMPORTS                                  -->
  <!-- ==================================================================== -->
  
  <xsl:import href="../.xslt-datura/tei_to_html/tei_to_html.xsl"/>
  <xsl:import href="../../../whitman-scripts/scripts/archive-wide/overrides.xsl"/>

  <!-- set in XSLT last minuite, move out into variable and delete pb rule -->
  <xsl:variable name="figure_collection"><xsl:text>whitman-manuscripts</xsl:text></xsl:variable>
  
  <!-- To override, copy this file into your collection's script directory
    and change the above paths to:
    "../../.xslt-datura/tei_to_html/lib/formatting.xsl"
 -->
  
  <!-- For display in TEI framework, have changed all namespace declarations to http://www.tei-c.org/ns/1.0. If different (e.g. Whitman), will need to change -->
  <xsl:output method="xml" indent="no" encoding="UTF-8" omit-xml-declaration="no"/>
  
  <!-- add overrides for this section here -->


  <xsl:variable name="top_metadata">
    <ul>
      <li>
        <strong>Source: </strong>
        <xsl:choose>
          <xsl:when
            test="//div1[@type = 'notebook'] | //text[@type = 'notebook'] | //text[@subtype = 'notebook']">
            <xsl:choose>
              <xsl:when test="//TEI//sourceDesc//bibl[not(@type = 'pasteon')]/title">
                <xsl:choose>
                  <xsl:when
                    test="count(//TEI//sourceDesc//bibl[not(@type = 'pasteon')]) &lt;= 1">
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[not(@type = 'pasteon')]/title"/>
                    <xsl:text>&#160;| &#160;</xsl:text>
                    <xsl:value-of select="//TEI//sourceDesc//bibl/orgName"/>
                  </xsl:when>
                  <xsl:when
                    test="count(//TEI//sourceDesc//bibl[not(@type = 'pasteon')]) = 2">
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[1][not(@type = 'pasteon')]/title"/>
                    <xsl:text>&#160;|&#160;</xsl:text>
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[1][not(@type = 'pasteon')]/orgName"/>
                    <br/>
                    <br/>
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[2][not(@type = 'pasteon')]/title"/>
                    <xsl:text>&#160;|&#160;</xsl:text>
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[2][not(@type = 'pasteon')]/orgName"
                    />
                  </xsl:when>
                  <xsl:when
                    test="count(//TEI//sourceDesc//bibl[not(@type = 'pasteon')]) = 3">
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[1][not(@type = 'pasteon')]/title"/>
                    <xsl:text>&#160;|&#160;</xsl:text>
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[1][not(@type = 'pasteon')]/orgName"/>
                    <br/>
                    <br/>
                    <xsl:value-of select="//TEI//sourceDesc//bibl[2]/title"/>
                    <xsl:text>&#160;|&#160;</xsl:text>
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[2][not(@type = 'pasteon')]/orgName"/>
                    <br/>
                    <br/>
                    <xsl:value-of select="//TEI//sourceDesc//bibl[3]/title"/>
                    <xsl:text>&#160;|&#160;</xsl:text>
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[3][not(@type = 'pasteon')]/orgName"
                    />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[not(@type = 'pasteon')]/title"/>
                    <xsl:text>&#160;| &#160;</xsl:text>
                    <xsl:value-of
                      select="//TEI//sourceDesc//bibl[not(@type = 'pasteon')]/orgName"
                    />
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="//TEI//sourceDesc//bibl/orgName"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          
          <xsl:when test="TEI/teiHeader/fileDesc/sourceDesc/biblStruct[not(@type='supplied')]">The transcription presented here is derived from <xsl:if test="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/author"><xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/author"/>, </xsl:if> <em><xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title"/></em><xsl:if test="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor">, ed. <xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor[1]"/><xsl:if test="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor[2]"><xsl:text> and </xsl:text><xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/editor[2]"/></xsl:if></xsl:if> (<xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr//pubPlace"/>: <xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr//publisher"/>, <xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr//date"/>), <xsl:if test="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr//biblScope[@type='volume']"><xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr//biblScope[@type='volume']"/>:</xsl:if><xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr//biblScope[@type='page']"/>. <xsl:if test="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/note[@type='project']"><xsl:apply-templates select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/note[@type='project']"/></xsl:if><xsl:text> </xsl:text><xsl:value-of select="TEI//sourceDesc//bibl[1]/orgName"/><xsl:if test="TEI//sourceDesc//bibl[2]/orgName"><xsl:text>; </xsl:text><xsl:value-of select="TEI//sourceDesc//bibl[2]/orgName"/></xsl:if></xsl:when>
          
          <xsl:otherwise>
            <xsl:value-of select="//TEI//sourceDesc//bibl[1]/orgName"/><xsl:if test="TEI//sourceDesc//bibl[2]/orgName"><xsl:text>; </xsl:text><xsl:value-of select="TEI//sourceDesc//bibl[2]/orgName"/></xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        
        <xsl:choose><xsl:when test="count(//TEI//sourceDesc//bibl) > 1 and //tei//sourceDesc//bibl[2]/orgname"><xsl:if test="not(ends-with(//TEI//sourceDesc//bibl[2]/orgName, '.'))"
          >.</xsl:if></xsl:when>
          <xsl:otherwise><xsl:if test="not(ends-with(//TEI//sourceDesc//bibl[1]/orgName, '.'))"
            >.</xsl:if></xsl:otherwise>
        </xsl:choose>
        <xsl:text>  </xsl:text>
        <xsl:apply-templates
          select="//TEI//sourceDesc//bibl[1]/note[@type = 'project'][not(@target)]"/>
        <xsl:choose>
          <xsl:when test="//div1[@type = 'notebook'] | //text[@type = 'notebook'] | //text[@subtype = 'notebook']"> For a description of the editorial rationale behind our treatment of the notebooks, see our <a href="../about/editorial-policies#notebooks">statement of editorial policy</a>.</xsl:when>
          <xsl:otherwise> For a description of the editorial rationale behind our treatment of the manuscripts, see our <a href="../about/editorial-policies#mss">statement of editorial policy</a>.</xsl:otherwise></xsl:choose>
      </li>

      <xsl:if test="/TEI/teiHeader/fileDesc/notesStmt/note">
        <li>
          <span class="bold">Editorial note: </span>
          <xsl:choose>
            <xsl:when
              test="/TEI/teiHeader/fileDesc/notesStmt/note[@type = 'project'][@target = ('#dat1', 'dat1')]">
              <xsl:apply-templates
                select="/TEI/teiHeader/fileDesc/notesStmt/note[@type = 'project'][@target = ('#dat1', 'dat1')]"/>
              <xsl:if
                test="/TEI/teiHeader/fileDesc/notesStmt/note[@type = 'project'][not(@target = ('#dat1', 'dat1'))][not(child::persName)]">
                <xsl:text> </xsl:text>
                <xsl:apply-templates
                  select="/TEI/teiHeader/fileDesc/notesStmt/note[@type = 'project'][not(@target = ('#dat1', 'dat1'))][not(child::persName)][1]"/>
                <xsl:if
                  test="/TEI/teiHeader/fileDesc/notesStmt/note[@type = 'project'][not(@target = ('#dat1', 'dat1'))][not(child::persName)][2]">
                  <xsl:text> </xsl:text>
                  <xsl:apply-templates
                    select="/TEI/teiHeader/fileDesc/notesStmt/note[@type = 'project'][not(@target = ('#dat1', 'dat1'))][not(child::persName)][2]"
                  />
                </xsl:if>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates
                select="/TEI/teiHeader/fileDesc/notesStmt/note[@type = 'project'][not(@target = ('#dat1', 'dat1'))][not(child::persName)]"
              />
            </xsl:otherwise>
          </xsl:choose>
        </li>
      </xsl:if>
      
      <!-- pulled from notebooks P5 tylesheet and refactored original comment: relatedItem section (updated 4/28/17)-->
      <!-- note that this differs from similar manuscripts override in that it does NOT check to see if file exists before creating link -->
      <xsl:if test="//sourceDesc//relatedItem">
        <li><strong>Related Item(s): </strong>
          <ul>
            <xsl:for-each select="//relatedItem[@type = 'text']">
                <xsl:variable name="note_id"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:variable>
                <xsl:variable name="note_target"><xsl:value-of select="//note[contains(@target,$note_id)]/@target"/></xsl:variable>
                <xsl:variable name="preceding_note_id">
                  <xsl:choose>
                  <xsl:when test="preceding-sibling::relatedItem">
                    <xsl:value-of select="preceding-sibling::relatedItem[1]/@xml:id"/>
                  </xsl:when>
                    <!--this is a sort of hacky workaround so the id can be checked below, sorry-->
                  <xsl:otherwise>zzz</xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
                <!-- if there is a note with a matching target and it does not match any previous targets, display -->
                <xsl:if test="not(contains($note_target,$preceding_note_id))">
                  <li><xsl:apply-templates select="//note[contains(@target,$note_id)]"/></li>
                </xsl:if>
              <!-- this part could probably be improved to create better handling for multiple relatedItems -->
              <li>
                  <xsl:text> See </xsl:text>
                <a>
                  <xsl:attribute name="href" select="@target"/>
                  <xsl:value-of select="@target"/>
                </a>
                <xsl:text>.</xsl:text>
              </li>
            </xsl:for-each>
          </ul>          
        </li>
      </xsl:if>
      <!--end relatedItem section-->
    </ul>
  </xsl:variable>
  
  <xsl:template match="note[@type='work_relations']"><!-- do nothing, these notes are suppressed --></xsl:template>
  
  <xsl:template match="pb">
    <!-- grab the figure id from @facs after tokenizing, and if there is a .jpg, chop it off
          note: I previously also looked at xml:id for figure ID, but that's 
          incorrect -->
    
    <xsl:variable name="pb_xmlid">
      <xsl:value-of select="@xml:id"/>
    </xsl:variable>
    <xsl:variable name="pb_n">
      <xsl:value-of select="@n"/>
    </xsl:variable>
    
    <xsl:for-each select="tokenize(@facs, ' ')">
      <xsl:variable name="figure_id">
        <xsl:variable name="figure_id_full">
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="ends-with($figure_id_full, '.jpg') or ends-with($figure_id_full, '.jpeg')">
            <xsl:value-of select="substring-before($figure_id_full, '.jp')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$figure_id_full"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      
      <span class="hr">&#160;
        <xsl:if test="starts-with($pb_xmlid,'leaf') and string-length($pb_xmlid) &gt;= 8">
          <xsl:variable name="id" select="$pb_xmlid"/>
          <xsl:variable name="page"><xsl:value-of select="xs:decimal(substring(substring-after($pb_xmlid,'leaf'),1,3))"/></xsl:variable>
          <xsl:variable name="last_character" select="substring($pb_xmlid,8,8)"/>
          <xsl:variable name="rectoverso">
            <xsl:choose>
              <xsl:when test="$last_character = 'r'">recto</xsl:when>
              <xsl:when test="$last_character = 'v'">verso</xsl:when>
            </xsl:choose>
          </xsl:variable>
          <xsl:text>[ begin leaf </xsl:text>
          <xsl:value-of select="$page"></xsl:value-of>
          <xsl:text> </xsl:text>
          <xsl:value-of select="$rectoverso"/>
          <xsl:text> ]</xsl:text>
        </xsl:if>
      </span>
      <xsl:if test="$figure_id != ''">
        <span>
          <xsl:attribute name="class">
            <xsl:text>pageimage</xsl:text>
          </xsl:attribute>
          <a>
            <!-- add id to links -->
            <xsl:attribute name="id">
              <xsl:value-of select="$pb_xmlid"/>
            </xsl:attribute>
            <!-- /add id to links -->
            <xsl:attribute name="href">
              <xsl:call-template name="url_builder">
                <xsl:with-param name="figure_id_local" select="$figure_id"/>
                <xsl:with-param name="image_size_local" select="$image_large"/>
                <xsl:with-param name="iiif_path_local" select="$figure_collection"/>
              </xsl:call-template>
            </xsl:attribute>
            <xsl:attribute name="rel">
              <xsl:text>prettyPhoto[pp_gal]</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
              <xsl:text>&lt;a href=&#34;</xsl:text>
              <xsl:call-template name="url_builder_escaped">
                <xsl:with-param name="figure_id_local" select="$figure_id"/>
                <xsl:with-param name="image_size_local" select="$image_large"/>
                <xsl:with-param name="iiif_path_local" select="$figure_collection"/>
              </xsl:call-template>
              <xsl:text>" target="_blank" &gt;open image in new window&lt;/a&gt;</xsl:text>
            </xsl:attribute>
            
            <img>
              <xsl:attribute name="src">
                <xsl:call-template name="url_builder">
                  <xsl:with-param name="figure_id_local" select="$figure_id"/>
                  <xsl:with-param name="image_size_local" select="$image_thumb"/>
                  <xsl:with-param name="iiif_path_local" select="$figure_collection"/>
                </xsl:call-template>
              </xsl:attribute>
              <xsl:attribute name="class">
                <xsl:text>display&#160;</xsl:text>
              </xsl:attribute>
            </img>
          </a>
        </span>
        <span class="page_image_description"><xsl:value-of select="."/></span>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>
