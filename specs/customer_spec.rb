# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative 'spec_helper'

RSpec.describe RewardSystem::Customer do
  describe 'Without a file upload' do
    it 'will not have any customers or invites' do
      expect(RewardSystem::REPO.customers).to be_empty
      expect(RewardSystem::REPO.invites).to be_empty
    end
  end

  describe 'With valid input data' do
    let(:new_customer) do
      RewardSystem::Customer.find_or_create(name: 'new customer')
    end
    let(:customer_invited) do
      RewardSystem::Customer.find_or_create(name: 'customer invited')
    end
    it 'adds a new customer' do
      expect { new_customer }.to change(
        RewardSystem::REPO.customers, :count
      ).by(1)
    end

    it 'finds the existing customers' do
      new_customer
      expect do
        RewardSystem::Customer.find_or_create(name: new_customer.name)
      end.to change(RewardSystem::REPO.customers, :count).by(0)
    end

    describe 'Customer properties' do
      before do
        RewardSystem::Invite.create(
          customer_id: new_customer.id,
          friend_id: customer_invited.id,
          status: 'accepts',
          invited_at: '2018-06-25 09:41'
        )
      end

      it 'returns true for a root user' do
        expect(new_customer.root?).to be_truthy
      end

      it 'returns false for a non root user' do
        expect(customer_invited.root?).to be_falsy
      end

      it 'contains root user' do
        expect(RewardSystem::Customer.roots).to include(new_customer)
      end

      it 'contains children' do
        expect(new_customer.children).to include(customer_invited)
      end

      it 'returns true for active?' do
        expect(new_customer.active?).to be_truthy
        expect(customer_invited.active?).to be_truthy
      end

      it 'returns parent' do
        expect(customer_invited.parent).to eq(new_customer)
        expect(new_customer.parent).to be_nil
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
