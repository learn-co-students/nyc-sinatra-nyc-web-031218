class Figure <ActiveRecord::Base
  has_many :titles, through: :figure_titles

end
