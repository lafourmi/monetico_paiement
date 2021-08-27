module MoneticoPaiement
  module FormHelper
    def monetico_paiement_form_tag(reference, price, form_options: {}, context:, email:, url_error:, url_success:, currency: 'EUR', locale: 'FR', ept: MoneticoPaiement::Ept.new, &block)
      form_tag ept.config.target_url, method: :post, authenticity_token: false, remote: false, enforce_utf8: false, **form_options do
        monetico_paiement_fields(reference, price,
          context: context, email: email, url_error: url_error,
          url_success: url_success, currency: currency, locale: locale, ept: ept) + capture(&block)
      end
    end

    def monetico_paiement_fields(reference, price, context:, email:, url_error:, url_success:, currency: 'EUR', locale: 'FR', ept: MoneticoPaiement::Ept.new)
      attributes = ept.attributes(reference, price,
        context: context, email: email, url_error: url_error,
        url_success: url_success, currency: currency, locale: locale)

      html = hidden_field_tag('MAC', ept.mac_string(attributes))

      attributes.each do |name, value|
        html << hidden_field_tag(name, value)
      end

      html
    end
  end
end
