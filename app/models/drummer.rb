class Drummer < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :country, presence: true
  validates :profile, presence: true

  enum country: {japan: 0, abroad: 1}

  def self.ransackable_attributes(auth_object = nil)
    %w[name country]
  end
end
