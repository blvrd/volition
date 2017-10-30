class MarketingController < ApplicationController
  def home
    if ENV['SELF_HOSTED'] == 'true'
      redirect_to login_path
    end
  end

  def running_costs
    first_month = Date.new(2016, 10)
    @list_data = [
      {
        label: 'Heroku',
        backgroundColor: 'rgba(150, 118, 185, 0.9)',
        description: 'Platform as a service. The Volition app is hosted on Heroku.',
        url: 'https://www.heroku.com/',
        data: [
          { x: first_month, y: 7 },
          { x: first_month.advance({ months: 1 }), y: 9.38 },
          { x: first_month.advance({ months: 2 }), y: 14.02 },
          { x: first_month.advance({ months: 3 }), y: 14.02 },
          { x: first_month.advance({ months: 4 }), y: 14.02 },
          { x: first_month.advance({ months: 5 }), y: 14.02 },
          { x: first_month.advance({ months: 6 }), y: 14.02 },
          { x: first_month.advance({ months: 7 }), y: 14.02 },
          { x: first_month.advance({ months: 8 }), y: 14.04 },
          { x: first_month.advance({ months: 9 }), y: 14.03 },
          { x: first_month.advance({ months: 10 }), y: 14.03 },
          { x: first_month.advance({ months: 11 }), y: 14.04 },
        ]
      },
      {
        label: 'Appsignal',
        backgroundColor: 'rgba(225, 100, 41, 0.9)',
        description: 'Error and bug reporting.',
        url: 'https://appsignal.com/',
        data: [
          { x: first_month, y: 0 },
          { x: first_month.advance({ months: 1 }), y: 3.72 },
          { x: first_month.advance({ months: 2 }), y: 12 },
          { x: first_month.advance({ months: 3 }), y: 12 },
          { x: first_month.advance({ months: 4 }), y: 12 },
          { x: first_month.advance({ months: 5 }), y: 12 },
          { x: first_month.advance({ months: 6 }), y: 12 },
          { x: first_month.advance({ months: 7 }), y: 12 },
          { x: first_month.advance({ months: 8 }), y: 12 },
          { x: first_month.advance({ months: 9 }), y: 12 },
          { x: first_month.advance({ months: 10 }), y: 12 },
          { x: first_month.advance({ months: 11 }), y: 12 },
        ]
      },
      {
        label: 'ExpeditedSSL',
        backgroundColor: 'rgba(37, 39, 43, 0.8)',
        description: 'SSL certificate provider.',
        url: 'https://www.expeditedssl.com/',
        data: [
          { x: first_month, y: 0 },
          { x: first_month.advance({ months: 1 }), y: 0 },
          { x: first_month.advance({ months: 2 }), y: 0 },
          { x: first_month.advance({ months: 3 }), y: 0 },
          { x: first_month.advance({ months: 4 }), y: 0 },
          { x: first_month.advance({ months: 5 }), y: 13.18 },
          { x: first_month.advance({ months: 6 }), y: 15 },
          { x: first_month.advance({ months: 7 }), y: 15 },
          { x: first_month.advance({ months: 8 }), y: 9.89 },
          { x: first_month.advance({ months: 9 }), y: 0 },
          { x: first_month.advance({ months: 10 }), y: 0 },
          { x: first_month.advance({ months: 11 }), y: 0 },
        ]
      },
      {
        label: 'Redis To Go',
        backgroundColor: 'rgba(184, 27, 15, 0.8)',
        description: 'Hosted Redis instance for background job processing.',
        url: 'http://redistogo.com/',
        data: [
          { x: first_month, y: 0 },
          { x: first_month.advance({ months: 1 }), y: 0 },
          { x: first_month.advance({ months: 2 }), y: 0 },
          { x: first_month.advance({ months: 3 }), y: 0 },
          { x: first_month.advance({ months: 4 }), y: 0 },
          { x: first_month.advance({ months: 5 }), y: 0 },
          { x: first_month.advance({ months: 6 }), y: 0 },
          { x: first_month.advance({ months: 7 }), y: 0 },
          { x: first_month.advance({ months: 8 }), y: 0 },
          { x: first_month.advance({ months: 9 }), y: 0 },
          { x: first_month.advance({ months: 10 }), y: 0 },
          { x: first_month.advance({ months: 11 }), y: 0 },
        ]
      },
      {
        label: 'Papertrail',
        backgroundColor: 'rgba(11, 79, 151, 0.8)',
        description: 'Server log management.',
        url: 'https://papertrailapp.com/',
        data: [
          { x: first_month, y: 0 },
          { x: first_month.advance({ months: 1 }), y: 0 },
          { x: first_month.advance({ months: 2 }), y: 0 },
          { x: first_month.advance({ months: 3 }), y: 0 },
          { x: first_month.advance({ months: 4 }), y: 0 },
          { x: first_month.advance({ months: 5 }), y: 0 },
          { x: first_month.advance({ months: 6 }), y: 0 },
          { x: first_month.advance({ months: 7 }), y: 0 },
          { x: first_month.advance({ months: 8 }), y: 0 },
          { x: first_month.advance({ months: 9 }), y: 0 },
          { x: first_month.advance({ months: 10 }), y: 0 },
          { x: first_month.advance({ months: 11 }), y: 0 },
        ]
      },
      {
        label: 'Mailgun',
        backgroundColor: 'rgba(180, 6, 15, 0.8)',
        description: 'Transactional email provider.',
        url: 'https://www.mailgun.com/',
        data: [
          { x: first_month, y: 0 },
          { x: first_month.advance({ months: 1 }), y: 0 },
          { x: first_month.advance({ months: 2 }), y: 0 },
          { x: first_month.advance({ months: 3 }), y: 0 },
          { x: first_month.advance({ months: 4 }), y: 0 },
          { x: first_month.advance({ months: 5 }), y: 0 },
          { x: first_month.advance({ months: 6 }), y: 0 },
          { x: first_month.advance({ months: 7 }), y: 0 },
          { x: first_month.advance({ months: 8 }), y: 0 },
          { x: first_month.advance({ months: 9 }), y: 0 },
          { x: first_month.advance({ months: 10 }), y: 0 },
          { x: first_month.advance({ months: 11 }), y: 0 },
        ]
      },

    ].map { |item| OpenStruct.new(item) }

    @total_cost_last_month = @list_data.reduce(0) do |total, dataset|
      total += dataset.data.last[:y]
      total
    end.round(2)

    gon.chartData = generate_chart_data(@list_data)
  end

  def privacy; end

  private

  def generate_chart_data(data)
    data.map do |hash|
      hash = hash.to_h
      {
        lineTension: 0,
        borderWidth: 1
      }.merge(hash)
    end
  end
end
