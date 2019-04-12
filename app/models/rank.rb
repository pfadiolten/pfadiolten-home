class Rank < ApplicationRecord
# Relations
  belongs_to :rankable, {
    polymorphic: true,
    required:    true,
  }

# Validations
  validates :value, {
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer:             true,
    },
    uniqueness: { scope: %i[ rankable_id rankable_type ] },
  }

# Scopes
  default_scope do
    order(:value)
  end

# Callbacks
  default_for :value do
    if (last_rankable = rankable.class.ordered.where('ranks.rankable_id IS NOT NULL').last)
      last_rankable.rank.value + 1
    else
      0
    end
  end
end
