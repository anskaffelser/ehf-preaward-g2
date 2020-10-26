
<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xi="http://www.w3.org/2001/XInclude"
				xmlns:u="utils"
				schemaVersion="iso" queryBinding="xslt2">

	<title>Rules for EHF Supplier List Light 1.0</title>

	<ns prefix="sl" uri="urn:fdc:anskaffelser.no:2019:ehf:schema:ParticipantList-1"/>
	<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
	<ns prefix="u" uri="utils"/>

  <xi:include href="../../../_common/function/mod11.xml"/>

  <pattern>
    <rule context="sl:EndpointID[@scheme = '0192']">
        <assert id="EHF-SL-R001"
                test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())"
                flag="fatal">MUST be a valid Norwegian organization number. Only numerical value allowed.</assert>
    </rule>

    <rule context="sl:ParticipantList/sl:FolderReference">
        <assert id="EHF-SL-R002"
                test="(sl:ID[@scheme = 'DOFFIN']) and (sl:ID[@scheme = 'TED'])"
                flag="fatal">Supplier list MUST contain Doffin and Ted reference number.</assert>
    </rule>

  </pattern>

</schema>
