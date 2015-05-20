# tell rails to use rspec format whenever it generates test code
Rails.application.config.generators do |g|
  g.test_framework :rspec, :view_specs => false,
                           :controller_specs => false,
                           :request_specs => false,
                           :routing_specs => false
end
