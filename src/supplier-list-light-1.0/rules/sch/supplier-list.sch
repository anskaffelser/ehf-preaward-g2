<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xi="http://www.w3.org/2001/XInclude"
				xmlns:u="utils"
				schemaVersion="iso" queryBinding="xslt2">

	<title>Rules for Supplier List Light 1.0</title>

	<ns prefix="pl" uri="urn:fdc:anskaffelser.no:2019:ehf:schema:ParticipantList-1"/>
	<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
	<ns prefix="u" uri="utils"/>

    <!-- Functions -->
    <include href="../../../_common/function/mod11.xml"/>

    <!-- Basic rules -->
    <include href="../../../../target/generated/supplier-list-light.sch"/>

	<!-- Rules -->

    <rule context="pl:ParticipantList">
        <assert id="..."
                test="count(pl:FolderReference/pl:ID[@scheme='TED']) &lt;= 1"
                flag="fatal">Maximum one TED reference may be provided.</assert>
    </rule>

    <rule context="pl:ParticipantList">
        <assert id="..."
                test="count(pl:FolderReference/pl:ID[@scheme='DOFFIN']) &lt;= 1"
                flag="fatal">Maximum one Doffin reference may be provided.</assert>
    </rule>

    <rule context="pl:CompanyID[@schemeID = '0192']">
        <assert id="..."
                test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())"
                flag="fatal">MUST be a valid Norwegian organization number. Only numerical value allowed.</assert>
    </rule>

</schema>
