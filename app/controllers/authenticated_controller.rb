class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_paid!
end
