# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe RewardSystem::RewardCalculator do
  before(:each) do
    RewardSystem::REPO.flush_all
  end

  describe 'RewardCalculator' do
    let(:file) { './specs/files/valid_file.txt' }
    it 'calculates rewards' do
      expect(RewardSystem::RewardCalculator.run(file)).to eq(
        'A' => 1.75, 'B' => 1.5, 'C' => 1.0
      )
    end
  end
end
