### convert ruby array to javascript array in slim


```ruby


= table_for @report do
  - columns :city, :amount

#piechart_3d style="width: 900px; height: 500px;"

script type="text/javascript" src="https://www.google.com/jsapi"

- chart_data(@report)

javascript:
  var chart_dd = #{raw chart_data(@report)}
  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawChart);
  function drawChart() {
    var data = google.visualization.arrayToDataTable(chart_dd);

    var options = {
      title: ' City Report',
      is3D: true,
    };

    var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
    chart.draw(data, options);
  } 




```

rails slim javascript embed ruby code,


just raw array in slim

or 

```ruby

<%= raw array.to_json%>

```
