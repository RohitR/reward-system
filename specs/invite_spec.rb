# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative 'spec_helper'

RSpec.describe RewardSystem::Invite do
  describe 'creates an invite' do
    let(:new_customer) do
      RewardSystem::Customer.find_or_create(name: 'new customer')
    end
    let(:customer_invited) do
      RewardSystem::Customer.find_or_create(name: 'customer invited')
    end
    let(:invite) do
      RewardSystem::Invite.create(
        customer_id: new_customer.id,
        friend_id: customer_invited.id,
        status: :pending,
        invited_at: '2018-06-25 09:41'
      )
    end

    it 'adds invite to invites repo' do
      expect { invite }.to change(RewardSystem::REPO.invites, :count).by(1)
    end

    it 'updates status' do
      RewardSystem::REPO.flush_all
      invite
      RewardSystem::Invite.update!(friend: customer_invited, status: 'accepts')
      expect(invite.status).to eq('accepts')
    end

    it 'raises exception CustomerNotInvited' do
      RewardSystem::REPO.flush_all
      expect do
        RewardSystem::Invite.update!(friend: customer_invited, status: 'accepts')
      end.to raise_error(RewardSystem::Errors::CustomerNotInvited)
    end

    it 'supplies accepted invites' do
      RewardSystem::REPO.flush_all
      invite
      RewardSystem::Invite.update!(friend: customer_invited, status: 'accepts')
      expect(RewardSystem::Invite.accepted).to contain_exactly(invite)
    end
  end
end
# rubocop:enable Metrics/BlockLength
