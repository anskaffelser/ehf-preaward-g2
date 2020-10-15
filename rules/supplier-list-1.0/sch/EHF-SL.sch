<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

    <rule context="cbc:EndpointID[@schemeID = '0192']">
        <assert id="EHF-SL-R001"
                test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())"
                flag="fatal">MUST be a valid Norwegian organization number. Only numerical value allowed.</assert>
    </rule>

    <rule context="ParticipantList">
        <assert id="EHF-SL-R003"
                test="(FolderReference/ID[@scheme = 'DOFFIN']) and (FolderReference/ID[@scheme = 'TED'])"
                flag="fatal">Supplier list MUST contain Doffin and Ted reference number.</assert>
    </rule>

     <rule context="cbc:EndpointID[@scheme = '0192']">
            <assert id="EHF-SL-R004"
                    test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())"
                    flag="fatal">MUST be a valid Norwegian organization number. Only numerical value allowed.</assert>
        </rule>


</pattern>
