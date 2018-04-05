class Title < ActiveRecord::Base
  has_many :figuretitles
  has_many :figures, through: :figuretitles

end
