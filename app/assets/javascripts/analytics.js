function barChart(data, max){
      var h = 300;
      var w = 500;
      var p = 30;

    var sampleSVG = d3.select(".chart")
        .style("width", w + "px")
        .style("border", "1px solid black");    

    d3.select(".chart")
      .selectAll("div")
        .data(data)
      .enter().append("div")
        .style("width", function(d){return (d / max * w) - 4 + "px";})
        .text(function(d){return d + " tweets";});

    var chart = d3.select(".chart");
    var bar = chart.selectAll("div");
    var barUpdate = bar.data(data);
    var barEnter = barUpdate.enter().append("div");
    barEnter.style("width", function(d) { return (d / max * w) - 4 + "px"; });
    


    }