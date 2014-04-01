(($) ->
  $(document).foundation()
)(jQuery)

taxes = null
taxesByCapita = null

d3.json 'http://data.ct.gov/resource/rkg9-smhd.json', (json) ->
  taxes = crossfilter json
  taxesByCapita = taxes.dimension ((d) -> d['tax_per_capita'])
