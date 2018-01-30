class SubscriptionPlan < ApplicationRecord
  include Payola::Plan

  def redirect_path(subscription)
    "/settings"
  end
end
