class RuleBasedRoutine < ActiveRecord::Base
  include Repeatable

  belongs_to :group

  has_one :rf_listener, -> { rf }, as: :routine, class_name: "Listener"
  has_one :rf_sensor, through: :rf_listener, source: :sensor

  has_many :listeners, -> { non_rf }, as: :routine, dependent: :destroy
  has_many :sensors, through: :listeners, source: :sensor

  has_many :callbacks, as: :routine, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :group }
  validates :group, presence: true
end