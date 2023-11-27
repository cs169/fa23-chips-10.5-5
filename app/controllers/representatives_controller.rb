# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    if params[:county]
      @representatives = Representative.where(county: params[:county])
    else
      @representatives = Representative.all
    end
  end

  def show
    @rep = Representative.find(params[:id])
    @rep_name = @rep.name ? @rep.name : "Name not found"
    @rep_ocdid = @rep.ocdid ? @rep.ocdid : "OC DID not found"
    @rep_title = @rep.title ? @rep.title : "Title not found"
    @rep_address = @rep.address ? "#{@rep.address[0]['line1']} #{@rep.address[0]['city']} #{@rep.address[0]['state']} #{@rep.address[0]['zip']}" : "Address not found"
    @rep_party = @rep.party ? @rep.party : "Party not found"

    render 'representatives/show'
  end
end
