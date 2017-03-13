module StripeHelper
  def stub_create_stripe_customer
    stub_request(:post, "https://api.stripe.com/v1/customers").to_return(
      status: 200,
      body: get_json_response('create_stripe_customer')
    )
  end

  def stub_retrieve_stripe_customer
    stub_request(:get, /customers/).to_return(
      status: 200,
      body: get_json_response('create_stripe_customer')
    )
  end

  def stub_create_stripe_subscription
    stub_request(:post, "https://api.stripe.com/v1/subscriptions").to_return(
      status: 200,
      body: get_json_response('create_stripe_subscription')
    )
  end

  def stub_retrieve_stripe_subscription
    stub_request(:get, /subscriptions/).to_return(
      status: 200,
      body: get_json_response('create_stripe_subscription')
    )
  end

  def get_json_response(filename)
    File.read(File.join('test', 'support', 'api_responses', "#{filename}.json"))
  end
end
