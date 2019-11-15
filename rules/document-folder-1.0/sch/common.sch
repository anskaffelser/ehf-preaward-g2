<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xi="http://www.w3.org/2001/XInclude"
				xmlns:u="utils"
				schemaVersion="iso" queryBinding="xslt2">

	<title>Rules for Document Reference profiles</title>

	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="ubl" uri="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2"/>
	<ns prefix="xhe" uri="oasis-cefact-xhe-1.0-ExchangeHeaderEnvelope"/>
	<ns prefix="xhb" uri="oasis-cefact-xhe-1.0-BasicComponents"/>
	<ns prefix="xha" uri="oasis-cefact-xhe-1.0-AggregateComponents"/>
	<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
	<ns prefix="u" uri="utils"/>


	<!-- Rules -->

    <include href="EHF-DF.sch"/>


</schema>
