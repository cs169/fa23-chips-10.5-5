# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      existing_rep = Representative.find_by(name: official.name)
      if existing_rep
        existing_rep.update({ 
          ocdid: ocdid_temp, 
          title: title_temp,
          address: existing_rep.address,
          party: existing_rep.party,
          photo_url: existing_rep.photo_url
        })
        reps.push(existing_rep)
      else
        rep = Representative.create!({ 
          name: official.name, 
          ocdid: ocdid_temp, 
          title: title_temp, 
          address: official.address,
          party: official.party,
          photo_url: official.photo_url
        })
        reps.push(rep)
      end
    end
    reps
  end
end
