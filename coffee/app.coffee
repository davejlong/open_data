(($) ->
  $(document).foundation()
)(jQuery)

taxes=null
taxesByCapita=null

d3.json 'http://data.ct.gov/resource/rkg9-smhd.json', (json) ->
  data = json.map((d) ->
    d.ct_income_tax =  Number(d.ct_income_tax)
    d.number_of_returns =  Number(d.number_of_returns)
    d.tax_per_capita = Number(d.tax_per_capita)
    d
  ).filter((d) ->
    d.municipality != "Total"
  ).sort((a, b) ->
    b.tax_per_capita - a.tax_per_capita
  )

  data = data[0..9]
  console.log data, data.length

  scale = d3.scale.linear()
    .domain([0, d3.max(data, (d) -> d.tax_per_capita)])
    .range([0, 100])

  colorScale = d3.scale.category20b()

  chart = d3.select('#chart').selectAll('div')
    .data(data).enter()
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
