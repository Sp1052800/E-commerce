OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '332966020451916', '0f1a9c658f2e847f10852db12bd8eb1f'
end