class TimeBasedRoutine < ActiveRecord::Base
  include Repeatable

  belongs_to :group

  has_one :callback, as: :routine, dependent: :destroy
  has_one :actor, through: :callback, source: :target, source_type: "Actor"

  validates :name, presence: true, uniqueness: { scope: :group }
  validates :triggers_at, presence: true
  validates :group, presence: true

  def crontab
    "#{triggers_at.min} #{triggers_at.hour} * * #{repeats_at.to_days_of_week.join(',')}"
  end

  def to_flow
    Nodered::TimeBasedRoutineSerializer.new(self).as_json
  end
end