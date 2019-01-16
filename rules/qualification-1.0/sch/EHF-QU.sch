<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

    <rule context="cac:DocumentResponse/cac:Response[normalize-space(cbc:ResponseCode) ='REJECTED']">
        <assert id="EHF-QU-R001"
                test="cbc:Description"
                flag="fatal">All rejections MUST be explained.</assert>
    </rule>


</pattern>
