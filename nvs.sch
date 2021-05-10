<?xml version="1.0" encoding="UTF-8"?>
<!-- ISO Schematron-->

<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
queryBinding="xslt2">

<!-- Declared NVS namespace   !!!!!! Target all elements directly with the "nvs:" prefix  !!!!!!!!  -->
<sch:ns uri="http://www.mla.org/NVSns" prefix="nvs"/>

<xsl:key name="keyID" match="@xml:id" use="."/>
	
<!-- Checks for uniqueness of each xml:id value -->
<sch:pattern id="UniqueID">
	<sch:rule context="*[@xml:id]">
		<sch:assert test="count(key('keyID', @xml:id)) = 1">––– Duplicate xml:id (<sch:value-of select="@xml:id"/>) –––</sch:assert>
	</sch:rule>
</sch:pattern>

	
<!-- Checks that all @target and @targetEnd attributes have matching xml:id values in the document -->
<sch:pattern id="MatchTarget">
	<sch:rule context="*[@target and not(@targType = 'url')]">
		<sch:assert test="every $t in (tokenize(@target,'\s+')) satisfies key('keyID', replace($t,'^#',''))">––– Unmatched @target (<sch:value-of select="@target"/>) –––</sch:assert>
	</sch:rule>
</sch:pattern>
<sch:pattern id="MatchTargetEnd">
	<sch:rule context="*[@targetEnd]">
		<sch:assert test="every $t in (tokenize(@targetEnd,'\s+')) satisfies key('keyID', replace($t,'^#',''))">––– Unmatched @targetEnd (<sch:value-of select="@targetEnd"/>) –––</sch:assert>
	</sch:rule>
</sch:pattern>


<!-- Checks that certain elements with @xml:id are targeted
<sch:pattern id="TargetedID">
	<sch:rule context="nvs:p[@xml:id] | nvs:anchor[@xml:id and @type='xref' ]">
		<sch:let name="targetedID" value="concat('#',@xml:id) = //nvs:ptr/@target  | //nvs:ptr/@targetEnd"/>
		<sch:assert test="$targetedID">––– Untargeted xml:id (<sch:value-of select="@xml:id"/>) –––</sch:assert>
	</sch:rule>
</sch:pattern>
-->

<!-- Checks that each @who on <sp> has a matching @xml:id on <role> -->
<sch:pattern id="MatchWho">
	<sch:rule context="nvs:sp[@who]">
		<sch:assert test="every $t in (tokenize(@who,'\s+')) satisfies key('keyID', replace($t,'^#',''))">––– Unmatched @who (<sch:value-of select="@who"/>) –––</sch:assert>
	</sch:rule>
</sch:pattern>

<!-- Confirms the correct @targType for a given @target prefix -->
<sch:pattern id="TargTypes">
	<sch:rule context="*[@targType]">		<sch:report test="contains(@target,'para_') and not(@targType = 'p')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'anchor_') and not(@targType = 'anchor')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'cn_') and not(@targType = 'note_cn')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'tn_') and not(@targType = 'note_tn')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'irr_') and not(@targType = 'note_irr')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'uc_') and not(@targType = 'note_uc')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'tln_') and not(@targType = 'lb')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'lb_') and not(@targType = 'lb')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'_l_') and not(@targType = 'l')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'lg_') and not(@targType = 'lg')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>		
		<sch:report test="starts-with(@target,'head_') and not(@targType = 'head')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'sp_') and not(@targType = 'sp')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'table_') and not(@targType = 'table')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'list_') and not(@targType = 'list')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'item_') and not(@targType = 'item')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'quote_') and not(@targType = 'quote')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
		<sch:report test="starts-with(@target,'figure_') and not(@targType = 'figure')">––– @targType (<sch:value-of select="@targType"/>) doesn't match @target (<sch:value-of select="@target"/>) –––</sch:report>
	</sch:rule>
</sch:pattern>

<!-- Checks that sequences of <ptr>s have the correct @mode values  
<sch:pattern id="PtrMode">
	<sch:rule context="nvs:ptr[@mode = 'list']">
		<sch:assert test="preceding-sibling::text()[position() = 1] = ', ' and preceding-sibling::*[position() = 1][self::nvs:ptr]">––– ptr[@mode="list"] out of sequence –––</sch:assert>
	</sch:rule>
	<sch:rule context="nvs:ptr[@mode = 'listFirst']">
		<sch:report test="preceding-sibling::text()[position() = 1] = ', ' and preceding-sibling::*[position() = 1][self::nvs:ptr]">––– ptr[@mode="listFirst]" out of sequence –––</sch:report>
	</sch:rule>
	<sch:rule context="nvs:ptr[not(@mode = 'listFirst') and not(@mode='list')]">
		<sch:report test="preceding-sibling::text()[position() = 1] = ', ' and preceding-sibling::*[position() = 1][self::nvs:ptr]">––– ptr in sequence, but without @mode –––</sch:report>
		<sch:report test="following-sibling::text()[position() = 1] = ', ' and following-sibling::*[position() = 1][self::nvs:ptr]">––– ptr in sequence, but without @mode –––</sch:report>
	</sch:rule>
</sch:pattern>
-->

<!-- Check for any straight tick apostrophes or quote marks in the text -->
<sch:pattern id="StraightQuotes">
	<sch:rule context="nvs:text//text()">
		<sch:report test="contains(., '''' )">––– Straight single quote mark –––</sch:report>
		<sch:report test="contains(., '&quot;' )">––– Straight double quote mark –––</sch:report>
	</sch:rule>
</sch:pattern>

<!-- Check that all @target and @targetEnd attributes begin with # (except for targType="url") -->
<sch:pattern id="TargetPound">
	<sch:rule context="*[@target and not(@targType = 'url')]">
		<sch:assert test="every $t in (tokenize(@target,'\s+')) satisfies starts-with($t, '#')">––– Internal target does not begin with "#" (<sch:value-of select="@target"/>) –––</sch:assert>
	</sch:rule>
</sch:pattern>
<sch:pattern id="TargetEndPound">
	<sch:rule context="*[@targetEnd]">
		<sch:assert test="every $t in (tokenize(@targetEnd,'\s+')) satisfies starts-with($t, '#')">––– Internal targetEnd does not begin with "#" (<sch:value-of select="@targetEnd"/>) –––</sch:assert>
	</sch:rule>
</sch:pattern>

<!-- Check that every <name type="app" is enclosed in <ref> or <sic> -->
<sch:pattern id="NameInRef">
	<sch:rule context="nvs:name[@type = 'app']">
		<sch:assert test="parent::nvs:ref or parent::nvs:sic or parent::nvs:bibl">––– Name type="app" is not enclosed in ref, sic, or bibl –––</sch:assert>
	</sch:rule>
</sch:pattern>

</sch:schema>