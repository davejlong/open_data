(($) ->
  $(document).foundation()
)(jQuery)

taxes=null
taxesByCapita=null

d3.json 'http://data.ct.gov/resource/rkg9-smhd.json', (json) ->
  taxes = crossfilter json.map((d) ->
    d.ct_income_tax =  Number(d.ct_income_tax)
    d.number_of_returns =  Number(d.number_of_returns)
    d.tax_per_capita = Number(d.tax_per_capita)
    d
  )
  taxesByCapita = taxes.dimension((d) -> d['tax_per_capita'])
    .filter (d) ->
      isFinite(d) && !isNaN(d)

  data = taxesByCapita.top 10
  scale = d3.scale.linear()
    .domain([0, d3.max(data, (d) -> d.tax_per_capita)])
    .range([0, 100])

  colorScale = d3.scale.category20b()

  chart = d3.select('#chart').selectAll('div')
    .data(taxesByCapita.top 10).enter()
    .append('div')
    .transition()
    .duration(2000)
    .style('width', (d) ->
      "#{scale(d.tax_per_capita)}%"
    )
    .style('background-color', (d) ->
      colorScale(d.tax_per_capita)
    ).text((d) ->
      "#{d.municipality} ($#{d.tax_per_capita.toString().replace(/(?=(\d{3})+(?!\d))/g, ',')})"
    )
  true
