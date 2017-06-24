if Rails.env.development? || Rails.env.test?

  namespace :dev do
    desc "Sample data for local development environment"
    task prime: "db:setup" do

      # create(:user, email: "user@example.com", password: "password")
    end
  end
end
