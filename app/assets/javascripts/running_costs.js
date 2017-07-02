$(document).on('turbolinks:load', function() {
  if ($('body').hasClass('marketing-running_costs')) {
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

    function getMaxPrice(datasets) {
      return datasets.reduce(function(max, dataset) {
        var maxInDataset = dataset.data.reduce(function(prev, next) {
          if (typeof prev == 'object') {
            return Math.max(prev.y, next.y)
          } else if (typeof prev == 'number') {
            return Math.max(prev, next.y)
          } else {
            return Math.max(0, next.y)
          }
        })

        if (maxInDataset > max) {
          max = maxInDataset
        }

        return max
      }, 0)
    }

    var datasets = gon.chartData
    var maxPrice = getMaxPrice(datasets)

    var myChart = new Chart(ctx, {
      type: 'line',
      data: {
        datasets: sortDataSetsByAverageAmount(datasets)
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
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
              max: maxPrice + (maxPrice * 0.20),
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
  }
})
