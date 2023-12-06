# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'rubocop analysis' do
  subject(:report) { `bundle exec rubocop` }

  let(:offenses_count) { report.scan(/\d+ offenses detected/).first.to_i }

  it 'has no offenses' do
    puts "RuboCop detected offenses:\n#{report}" if offenses_count > 0
    expect(offenses_count).to eq(0)
  end
end
