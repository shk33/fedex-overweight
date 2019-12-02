class Report < ApplicationRecord
  validates :stringified_summary, presence: true
end
