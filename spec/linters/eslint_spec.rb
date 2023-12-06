# frozen_string_literal: true

require 'English'
require 'spec_helper'

RSpec.describe 'eslint analysis' do
  subject(:report) { `yarn run lint` }

  let(:exit_status) { $CHILD_STATUS.exitstatus } # captures the exit status of the last executed shell command

  it 'has no offenses' do
    expect(exit_status).to eq(0) # ESLint exits with 0 on success
    expect(report).not_to include('error') # assuming ESLint outputs 'error' for any issues
  end
end
