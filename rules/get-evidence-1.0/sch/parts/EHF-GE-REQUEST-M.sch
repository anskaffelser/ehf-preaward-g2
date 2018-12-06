<?xml version="1.0" encoding="UTF-8"?>

  <pattern xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <rule context="cac:TenderingCriterionProperty">
    <assert id="EHF-GE-R041"
      test="count(key('k_lineId',cbc:ID)) = 1"
      flag="fatal">Each evidence request line SHALL have a line identifier that is unique within the transaction.</assert>
    </rule>
    
  </pattern>


