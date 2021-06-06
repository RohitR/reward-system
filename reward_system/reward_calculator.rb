# frozen_string_literal: true

module RewardSystem
  # Traversing through the tree depth wise.
  # backtracing at each node to update parent nodes.
  class RewardCalculator
    POINT_BASE = 0.5

    def self.run(file)
      RewardSystem::Db.prepare(file)
      traverse(Customer.roots)
    end

    def self.traverse(roots, scores = {})
      return if roots.empty?

      roots.each do |root|
        scores = backtrack(root, scores)  if root.parent
        traverse(root.children, scores)
      end
      scores
    end

    def self.backtrack(root, scores, level = 0)
      parent = root.parent
      name = parent.name

      scores[name] = scores[name].to_f + POINT_BASE**level
      level += 1
      backtrack(parent, scores, level) if parent.parent
      scores
    end
  end
end
