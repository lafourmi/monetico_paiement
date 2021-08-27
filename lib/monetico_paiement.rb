# frozen_string_literal: true

require "monetico_paiement/version"
require "monetico_paiement/parameters"
require "monetico_paiement/ept"
require "monetico_paiement/railtie" if defined?(Rails)

module MoneticoPaiement
  class Error < StandardError; end

  API_VERSION = "3.0"
  DATE_FORMAT = "%d/%m/%Y:%H:%M:%S"

  END_POINTS = {
    production: 'https://p.monetico-services.com/paiement.cgi',
    test: 'https://p.monetico-services.com/test/paiement.cgi'
  }
  DEFAULT_ENV = :test

  def self.configure(&block)
    yield default_config
  end

  def self.default_config
    @@default_config ||= MoneticoPaiement::Config.new
  end

  class Config
    attr_accessor :hmac_key, :ept_number, :company_code, :env
    attr_writer :target_url

    def initialize(hmac_key: nil, ept_number: nil, company_code: nil, env: MoneticoPaiement::DEFAULT_ENV, target_url: nil)
      self.hmac_key = hmac_key
      self.ept_number = ept_number
      self.company_code = company_code
      self.env = env
      self.target_url = target_url
    end

    def target_url
      @target_url || END_POINTS[env]
    end
  end
end
