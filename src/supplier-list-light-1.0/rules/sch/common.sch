<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xi="http://www.w3.org/2001/XInclude"
				xmlns:u="utils"
				schemaVersion="iso" queryBinding="xslt2">

	<title>Rules for Supplier list profiles</title>

	<ns uri="urn:fdc:anskaffelser.no:2019:ehf:schema:ParticipantList-1"/>
	<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
	<ns prefix="u" uri="utils"/>


	<!-- Rules -->

    <rule context="EndpointID[@schemeID = '0192'] | CompanyID[@schemeID = '0192']">
        <assert id="EHF-SL-R001"
                test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())"
                flag="fatal">MUST be a valid Norwegian organization number. Only numerical value allowed.</assert>
    </rule>

    <rule context="ParticipatingParty/FolderReference">
        <assert id="EHF-SL-R002"
                test="ID[@scheme = 'LOT']"
                flag="fatal">If the Participating Party's Folder Reference is used, then the LOT reference MUST be provided.</assert>
    </rule>

    <rule context="ParticipantList">
        <assert id="EHF-SL-R003"
                test="(FolderReference/ID[@scheme = 'DOFFIN']) and (FolderReference/ID[@scheme = 'TED'])"
                flag="fatal">Supplier list MUST contain Doffin and Ted reference number.</assert>
    </rule>

</schema>
