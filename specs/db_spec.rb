# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative 'spec_helper'

RSpec.describe RewardSystem::Db do
  before(:each) do
    RewardSystem::REPO.flush_all
  end
  describe 'with valid file' do
    let(:file) { './specs/files/valid_file.txt' }
    it 'prepares db' do
      expect(RewardSystem::Db.prepare(file)).to be_truthy
      expect(RewardSystem::REPO.customers).not_to be_empty
      expect(RewardSystem::REPO.invites).not_to be_empty
    end
  end

  describe 'with invalid files' do
    describe 'customer already exists' do
      let(:file) { './specs/files/customer_exists.txt' }
      it 'raises CustomerExists exception while preparing db' do
        expect do
          RewardSystem::Db.prepare(file)
        end.to raise_error(RewardSystem::Errors::CustomerExists)
      end
    end

    describe 'customer not esists in the system' do
      let(:file) { './specs/files/customer_not_found.txt' }
      it 'raises CustomerNotFound exception while preparing db' do
        expect do
          RewardSystem::Db.prepare(file)
        end.to raise_error(RewardSystem::Errors::CustomerNotFound)
      end
    end

    describe 'Inactive customer recommends' do
      let(:file) { './specs/files/inactive_customer.txt' }
      it 'raises CustomerInactive exception while preparing db' do
        expect do
          RewardSystem::Db.prepare(file)
        end.to raise_error(RewardSystem::Errors::CustomerInactive)
      end
    end

    describe 'Customer recommends itself' do
      let(:file) { './specs/files/customer_recommends_itself.txt' }
      it 'raises CustomerRecommendsItself exception while preparing db' do
        expect do
          RewardSystem::Db.prepare(file)
        end.to raise_error(RewardSystem::Errors::CustomerRecommendsItself)
      end
    end

    describe 'Customer name is blank' do
      let(:file) { './specs/files/customer_name_blank.txt' }
      it 'raises CustomerNameBlank exception while preparing db' do
        expect do
          RewardSystem::Db.prepare(file)
        end.to raise_error(RewardSystem::Errors::CustomerNameBlank)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
