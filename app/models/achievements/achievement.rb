class Achievement < ActiveRecord::Base
  belongs_to :player
  validates_uniqueness_of :player_id, :scope => :type


end
