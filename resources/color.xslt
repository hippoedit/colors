<?xml version="1.0"?>
<xslt:stylesheet xmlns:xslt="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xslt:template match="XMLConfigSettings">
    <html>
      <HEAD>
        <TITLE>
          <xslt:value-of select="FILEINFO/@type"/> (<xslt:value-of select="FILEINFO/@author"/>)
        </TITLE>
        <link href="./../styles.css" rel="stylesheet" type="text/css"/>
        <script src="./../sorting_table.js" type="text/javascript"></script>
        <script type="text/javascript">
          function init()
          {
          var TableSorter = new TSorter;
          TableSorter.init('sorting_table', '0');
          }
          window.onload = init;
        </script>
      </HEAD>
      <BODY>
        <xslt:apply-templates select="FILEINFO"/>
        <xslt:apply-templates select="PALETTE"/>
      </BODY>
    </html>
  </xslt:template>

  <xslt:template match="FILEINFO">
    <h3>File information</h3>
    <table>
      <tr>
        <td class="TD-KEY">Author</td>
        <td>
          <xslt:value-of select="@author"/>
        </td>
      </tr>
      <tr>
        <td class="TD-KEY">Data type</td>
        <td>
          <xslt:value-of select="@type"/>
        </td>
      </tr>
    </table>
  </xslt:template>

  <xslt:template match="PALETTE">
    <h3>
      Color palette for <xslt:value-of select="@name"/>
    </h3>
    <table id="sorting_table" class="sortable">
      <thead>
        <tr class="TR-HEADER">
          <th>№</th>
          <th>Name</th>
          <th>Color</th>
          <th>Text</th>
          <th>Background</th>
        </tr>
      </thead>
      <tbody>
        <xslt:for-each select="Index">
          <tr class="TR-NORMAL">
            <td abbr="image_number" class="key">
              <xslt:value-of select="position()"/>
            </td>
            <td>
              <xslt:value-of select="@name"/>
            </td>
            <xslt:call-template name="color" >
              <xslt:with-param name="td-color" select="@color"/>
            </xslt:call-template>
            <xslt:call-template name="boolean" >
              <xslt:with-param name="value" select="@fore"/>
            </xslt:call-template>
            <xslt:call-template name="boolean" >
              <xslt:with-param name="value" select="@back"/>
            </xslt:call-template>
          </tr>
        </xslt:for-each>
      </tbody>
    </table>
  </xslt:template>

  <xslt:template name="color">
    <xslt:param name="td-color" select="string('#FFFFFFFF')"/>
    <xslt:choose>
      <xslt:when test="$td-color > 0">
        <td>
          <xslt:attribute name="style">
            background:rgb(<xslt:value-of select="$td-color mod 256"/>,<xslt:value-of select="($td-color div 256) mod 256"/>,<xslt:value-of select="($td-color div 65536) mod 256"/>)
          </xslt:attribute>
        </td>
      </xslt:when>
      <xslt:when test="$td-color = string('#FFFFFFFF')">
        <td>
          Transparent
        </td>
      </xslt:when>
      <xslt:when test="$td-color = string('#FFFFFF00')">
        <td>
          Automatic
        </td>
      </xslt:when>
      <xslt:otherwise>
        <td>
          <xslt:attribute name="style">
            background-color: <xslt:value-of select="substring(string($td-color), 1, 7)"/>
          </xslt:attribute>
          <xslt:value-of select="$td-color"/>
        </td>
      </xslt:otherwise>
    </xslt:choose>
  </xslt:template>

  <xslt:template name="boolean">
    <xslt:param name="value" select="0"/>
    <xslt:choose>
      <xslt:when test="$value = 1">
        <td>
          <center>X</center>
        </td>
      </xslt:when>
      <xslt:when test="$value = string('true')">
        <td>
          <center>X</center>
        </td>
      </xslt:when>
      <xslt:otherwise>
        <td></td>
      </xslt:otherwise>
    </xslt:choose>
  </xslt:template>
</xslt:stylesheet>
