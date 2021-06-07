# frozen_string_literal: true

module RewardSystem
  # Customer represents the nodes in the system
  # Each node having prperties like parent, children and id
  class Customer
    attr_reader :name, :id
    def self.find_or_create(name:)
      customer = find_by_name(name)

      unless customer
        customer = new(name: name)
        REPO.add_customer(customer)
      end
      customer
    end

    def root?
      Customer.roots.include? self
    end

    def active?
      # Either a root or accepted invitation
      root? || Invite.accepted.any? { |invitation| invitation.friend_id == id }
    end

    def self.roots
      # roots are top level customers. They are not recommended by others
      # Root should have at least one recommendation which is accepted

      REPO.customers.select do |customer|
        Invite.accepted.none? { |invite| invite.friend_id == customer.id } &&
          REPO.invites.any? { |invite| invite.customer_id == customer.id }
      end
    end

    def absolute_root?
      REPO.invites.none? { |invite| invite.friend_id == id }
    end

    def parent
      # Any customer other than root will have an accepted invite.
      # Invite can be used to identify the invited.
      return nil if Customer.roots.include? self

      invite = Invite.accepted.find { |inv| inv.friend_id == id }
      Customer.find_by_id(invite.customer_id)
    end

    def children
      # Children are first level recommendations.
      # Invitations should be in accepted state.

      invites = Invite.accepted.select { |invite| invite.customer_id == id }
      invites.map { |invite| Customer.find_by_id(invite.friend_id) }
    end

    private_class_method :new

    def self.find_by_name(name)
      REPO.customers.find { |customer| customer.name == name }
    end

    def self.find_by_id(id)
      REPO.customers.find { |customer| customer.id == id }
    end

    def initialize(name:)
      @name = name
      @id = SecureRandom.uuid
    end
  end
end
