# frozen_string_literal: true

# Serves common AJAX requests.
class AjaxController < ApplicationController
  def counties
    @state = State.find_by(symbol: params[:state_symbol].upcase)
    if @state
      render json: @state.counties
    else
      render json: [] # Render an empty array if state is not found
    end
  end
end
