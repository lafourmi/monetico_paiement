require 'monetico_paiement/form_helper'

module MoneticoPaiement
  class Railtie < Rails::Railtie
    initializer "monetico_paiement.form_helpers" do
      ActionView::Base.send :include, FormHelper
    end
  end
end
