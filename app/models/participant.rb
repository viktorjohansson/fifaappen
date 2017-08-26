class Participant < ActiveRecord::Base
  belongs_to :player
  belongs_to :round
  belongs_to :match
end
