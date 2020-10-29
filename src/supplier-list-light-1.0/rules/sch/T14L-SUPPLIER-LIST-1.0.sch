<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xi="http://www.w3.org/2001/XInclude"
				xmlns:u="utils"
				schemaVersion="iso" queryBinding="xslt2">

	<title>Rules for EHF Supplier List Light 1.0</title>

	<ns prefix="es" uri="urn:fdc:anskaffelser.no:2019:ehf:schema:ParticipantList-1"/>
	<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
	<ns prefix="u" uri="utils"/>

    <!-- Functions -->
    <xi:include href="../../../_common/function/mod11.xml"/>

    <!-- Basic rules -->
    <include href="../../../../target/generated/t14l-basic-1.0.sch"/>

    <pattern>
        <!-- Rules: Empty elements -->

        <rule context="es:ParticipantList | es:FolderReference | es:ParticipatingParty | es:Party | es:ElectronicMail | es:Telephone">
            <!-- Skipping -->
        </rule>

        <rule context="es:Contact">
            <assert id="EHF-T14L-R021"
                    test="count(*) != 0"
                    flag="fatal">Document MUST not contain empty elements.</assert>
        </rule>
        
        <rule context="es:*">
            <assert id="EHF-T14L-R022"
                    test="normalize-space() != ''"
                    flag="fatal">Document MUST not contain empty elements.</assert>
        </rule>

    </pattern>

    <pattern>
        <!-- Rules: References -->

        <rule context="es:ParticipantList">
            <assert id="EHF-T14L-R001"
                    test="count(es:FolderReference/es:ID[@scheme = 'DOFFIN']) &lt;= 1"
                    flag="fatal">Maximum one Doffin reference may be provided.</assert>
            <assert id="EHF-T14L-R002"
                    test="count(es:FolderReference/es:ID[@scheme = 'TED']) &lt;= 1"
                    flag="fatal">Maximum one TED reference may be provided.</assert>
        </rule>


        <!-- Rules: Content validation -->

        <rule context="es:CompanyID[@scheme = '0192']">
            <assert id="EHF-T14L-R011"
                    test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())"
                    flag="fatal">MUST be a valid Norwegian organization number. Only numerical value allowed.</assert>
        </rule>

        <rule context="es:ElectronicMail">
            <assert id="EHF-T14L-R012"
                    test="matches(normalize-space(), '(\w+[._])*\w+@(\w+\.)*\w+')"
                    flag="fatal">Invalid electronic mail address is provided.</assert>
        </rule>

        <rule context="es:Telephone">
            <assert id="EHF-T14L-R013"
                    test="matches(normalize-space(), '\+[0-9]+')"
                    flag="fatal">Telephone number must contain the international dialing prefix.</assert>
        </rule>

    </pattern>

</schema>
