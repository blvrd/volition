var ctx = document.getElementById("myChart")
Chart.defaults.global.defaultFontFamily = 'Karla'
Chart.defaults.global.defaultFontSize = 14

function getDataSetAverage(dataset) {
  return dataset.data.reduce(function(avg, datum) {
    avg = avg + datum.y
    return avg
  }, 0) / dataset.data.length
}

function sortDataSetsByAverageAmount(datasets) {
  return datasets.sort(function(first, next) {
    return getDataSetAverage(first) - getDataSetAverage(next)
  })
}

var datasets = gon.chartData

var myChart = new Chart(ctx, {
  type: 'line',
  data: {
    datasets: sortDataSetsByAverageAmount(datasets)
  },
  options: {
    tooltips: {
      backgroundColor: '#49be5a',
      xPadding: 10,
      yPadding: 10,
      titleFontSize: 16,
      callbacks: {
        title: function(tooltipItem, data) {
          return data.datasets[tooltipItem[0].datasetIndex].label
        },
        label: function(tooltipItem, data) {
          return '$' + tooltipItem.yLabel
        }
      }
    },
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero:true,
          callback: function(value) {
            return '$' + value
          }
        }
      }],
      xAxes: [{
        type: 'time',
        display: true,
        time: {
          unit: 'month',
          displayFormats: {
            month: 'MMM YYYY'
          }
        }
      }]
    }
  }
})
