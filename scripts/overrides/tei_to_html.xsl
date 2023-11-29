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
    </ul>
  </xsl:variable>
  
</xsl:stylesheet>
