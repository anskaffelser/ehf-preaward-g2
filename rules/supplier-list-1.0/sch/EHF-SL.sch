<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

    <rule context="cbc:EndpointID[@schemeID = '0192']">
        <assert id="EHF-SL-R001"
                test="matches(normalize-space(), '^[0-9]{9}$') and u:mod11(normalize-space())"
                flag="fatal">MUST be a valid Norwegian organization number. Only numerical value allowed</assert>
    </rule>

    <rule context="ParticipatingParty/FolderReference">
        <assert id="EHF-SL-R002"
                test="ID[@scheme = 'LOT']"
                flag="fatal">Participating Party MUST contain LOT reference.</assert>
    </rule>

    <rule context="FolderReference">
        <assert id="EHF-SL-R003"
                test="(ID[@scheme = 'DOFFIN']) or (ID[@scheme = 'TED'])"
                flag="fatal">Supplier list MUST contain Doffin and Ted reference.</assert>
    </rule>

</pattern>
