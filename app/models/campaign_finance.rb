# frozen_string_literal: true

require 'net/http'
require 'uri'

class CampaignFinance < ApplicationRecord
  def self.get_top_20_candidates(cycle, category)
    url = URI.parse("https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    request = Net::HTTP::Get.new(url.path, { 'X-API-Key' => Rails.application.credentials[:PROPUBLICA_API_KEY] })
    response = http.request(request)
    if response.code.to_i == 200
      JSON.parse(response.body)['results']

    else
      Rails.logger.debug { "API request failed with status code: #{response.code}" }
      nil
    end
  end
end
