# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = if params[:county]
                         Representative.where(county: params[:county])
                       else
                         Representative.all
                       end
  end
end
