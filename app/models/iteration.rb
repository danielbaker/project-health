class Iteration < ActiveRecord::Base
  validates :name, presence: true
  validates :project_id, presence: true
  attr_accessible :name
  CURRENT = 'current'
  PAST = 'past'

  belongs_to :project
  has_many :ratings
  has_many :comments

  def self.current(project)
    Iteration.where(project: project, status: CURRENT).first
  end

  def self.previous(project)
    Iteration.where(project: project, status: PAST).order('sort_order DESC').first
  end
end
