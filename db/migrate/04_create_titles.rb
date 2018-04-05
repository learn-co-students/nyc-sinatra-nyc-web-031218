class CreateTitles < ActiveRecord::Migration[4.2]
  # raise "Write CreateLandmarks migration here"
  def change
    create_table :titles do |t|
      t.string :name
    end
  end
end
