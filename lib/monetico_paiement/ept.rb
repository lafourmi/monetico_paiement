require 'base64'
require 'openssl'
require 'json'

module MoneticoPaiement
  class Ept
    attr_reader :config

    def initialize(config = nil)
      @config = config ? config : MoneticoPaiement.default_config
    end

    def attributes(reference, price, context:, email:, url_error:, url_success:, text: '', currency: 'EUR', locale: 'FR')
      {
        TPE: config.ept_number,
        contexte_commande: Base64.strict_encode64(context.to_json),
        date: Time.now.strftime(MoneticoPaiement::DATE_FORMAT),
        lgue: locale,
        mail: email,
        montant: ("%.2f" % price) + currency,
        reference: reference,
        societe: config.company_code,
        'texte-libre': text,
        url_retour_err: url_error,
        url_retour_ok: url_success,
        version: MoneticoPaiement::API_VERSION
      }
    end

    def mac_string(params)
      compute_hmac_sha1 generate_data(params)
    end

    def valid_hmac?(params)
      return false unless params.key?('MAC')

      mac_string(params) == params['MAC'].downcase
    end

    private

    def generate_data(params)
      params.reject { |k| k == 'MAC' }
        .sort
        .map { |pair| pair.join('=') }
        .join('*')
    end

    def compute_hmac_sha1(data)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, usable_key, data).downcase
    end

    def usable_key
      hex_string_key  = config.hmac_key[0..37]
      hex_final   = config.hmac_key[38..40] + "00";

      cca0 = hex_final[0].ord

      if cca0 > 70 && cca0 < 97
        hex_string_key += (cca0 - 23).chr + hex_final[1..2]
      elsif hex_final[1..2] == "M"
        hex_string_key += hex_final[0..1] + "0"
      else
        hex_string_key += hex_final[0..2]
      end

      [hex_string_key].pack("H*")
    end
  end
end
