<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:template match="/">
	<html>
	<head>
	<title>X2/X3 Script: <xsl:value-of select="script/name"/></title>
	</head>
	<body style="color:white;background-color:black">
	<xsl:apply-templates/>
	</body>
	</html>
</xsl:template>

<xsl:template match="script">
	<h1>Script <xsl:value-of select="name"/></h1>
	Version: <xsl:value-of select="version"/><br/>
	for Script Engine Version: <xsl:value-of select="engineversion"/><br/>
	<h3>Description</h3>
	<xsl:value-of select="description"/>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="name">
</xsl:template>
<xsl:template match="version">
</xsl:template>
<xsl:template match="engineversion">
</xsl:template>
<xsl:template match="description">
</xsl:template>

<xsl:template match="arguments">
	<h3>Arguments</h3>
	<ul>
	<xsl:apply-templates/>
	</ul>
</xsl:template>

<xsl:template match="argument">
	<li>
	<xsl:value-of select="@index"/>: <xsl:value-of select="@name"/> , <xsl:value-of select="@type"/> , '<xsl:value-of select="@desc"/>'
	</li>
</xsl:template>

<xsl:template match="sourceplaintext">
</xsl:template>

<xsl:template match="sourcetext">
	<h3>Source Text</h3>
	<div style="color:white;background-color:darkgray">
	<br/>
	<code>
	<xsl:apply-templates/>
	</code>
	<br/>
	</div>
</xsl:template>

  <xsl:template match="line">
    <b style="color:blue"><xsl:number format="001"/>&#160;<xsl:choose><xsl:when test="@interruptable"><b style="color:cyan"><xsl:value-of select="@interruptable"/></b></xsl:when><xsl:otherwise>&#160;</xsl:otherwise></xsl:choose></b>&#160;<b style="color:#777777"><xsl:value-of select="translate(@indent,'&#160;','|&#255;')"/></b><xsl:apply-templates/><br/>
  </xsl:template>

  <xsl:template match="text">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="var">
    <b style="color:darkgreen">
      <xsl:value-of select="."/>
    </b>
  </xsl:template>

  <xsl:template match="comment"><b style="color:black"><xsl:value-of select="."/></b></xsl:template>

  <xsl:template match="call">'<a><xsl:attribute name="href"><xsl:value-of select="."/>.xml</xsl:attribute><xsl:value-of select="."/></a>'</xsl:template>

  <xsl:template match="codearray">
  </xsl:template>
  <xsl:template match="signature">
    <br/>signed
  </xsl:template>
  <xsl:template match="nosignature">
  </xsl:template>

</xsl:stylesheet>
