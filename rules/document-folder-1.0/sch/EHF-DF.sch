<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

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
