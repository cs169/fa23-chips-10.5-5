# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = if params[:county]
                         Representative.where(county: params[:county])
                       else
                         Representative.all
                       end
  end

  def show
    @rep = Representative.find(params[:id])
    @rep_name = @rep.name || 'Name not found'
    @rep_ocdid = @rep.ocdid || 'OC DID not found'
    @rep_title = @rep.title || 'Title not found'
    @rep_party = @rep.party || 'Party not found'
    @rep_address =
      if @rep.address
        "#{@rep.address[0]['line1']} #{@rep.address[0]['city']} #{@rep.address[0]['state']} #{@rep.address[0]['zip']}"
      else
        'Address not found'
      end

    render 'representatives/show'
  end
end
