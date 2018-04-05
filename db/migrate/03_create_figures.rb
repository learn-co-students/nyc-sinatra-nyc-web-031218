class CreateFigures < ActiveRecord::Migration[4.2]
  # raise "Write CreateLandmarks migration here"
  def change
    create_table :figures do |t|
      t.string :name
    end
  end
end
