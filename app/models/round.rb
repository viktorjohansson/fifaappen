class Round < ActiveRecord::Base
  serialize :schedule, Array
  has_many :participants
  has_many :players, :through => :participants, :dependent => :destroy
  has_many :matches, :through => :participants
end
