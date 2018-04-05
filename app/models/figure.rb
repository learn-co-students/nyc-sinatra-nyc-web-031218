class Figure < ActiveRecord::Base
  has_many :landmarks
  has_many :figuretitles
  has_many :titles, through: :figuretitles

end
