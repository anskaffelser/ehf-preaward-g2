<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xi="http://www.w3.org/2001/XInclude"
				xmlns:u="utils"
				schemaVersion="iso" queryBinding="xslt2">

	<title>Rules for EHF Document Folder 1.0</title>

  <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
  <ns prefix="ubl" uri="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2"/>
  <ns prefix="xhe" uri="oasis-cefact-xhe-1.0-ExchangeHeaderEnvelope"/>
  <ns prefix="xhb" uri="oasis-cefact-xhe-1.0-BasicComponents"/>
  <ns prefix="xha" uri="oasis-cefact-xhe-1.0-AggregateComponents"/>
	<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
	<ns prefix="u" uri="utils"/>

  <!-- Functions rules -->
  <xi:include href="../../../src/_common/function/mod11.xml"/>

  <!-- Document Folder - organization number rules -->
  <pattern>
      <rule context="cbc:EndpointID[@schemeID = '0192']">
          <assert id="EHF-DF-R001"
                  test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())"
                  flag="fatal">MUST be a valid Norwegian organization number. Only numerical value allowed</assert>
      </rule>

      <rule context="xha:PartyIdentification/xhb:ID[@scheme = '0192']">
          <assert id="EHF-DF-R002"
                  test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())"
                  flag="fatal">MUST be a valid Norwegian organization number. Only numerical value allowed</assert>
      </rule>


  </pattern>

</schema>
