# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    if params[:county]
      @representatives = Representative.where(county: params[:county])
    else
      @representatives = Representative.all
    end
  end
end
