class Listener < ActiveRecord::Base
  belongs_to :routine, polymorphic: true
  belongs_to :sensor

  validates :routine, presence: true
  validates :sensor, presence: true
  validates :gt, absence: true, unless: -> { sensor.digital? }
  validates :lt, absence: true, unless: -> { sensor.digital? }
  validate -> {
    unless [gt, lt].any?
      errors.add(:gt, "digital sensors require at least one numeric conditions")
      errors.add(:lt, "digital sensors require at least one numeric conditions")
    end
  }, if: :digital?
  validate -> {
    unless gt < lt
      errors.add(:gt, "gt should be less than lt")
      errors.add(:lt, "gt should be less than lt")
    end
  }, unless: -> { [gt, lt].none? }

  delegate :binary?, :digital?, to: :sensor

  scope :rf, -> { joins(:sensor).merge(Sensor.binary) }
  scope :non_rf, -> { joins(:sensor).merge(Sensor.digital) }
end
