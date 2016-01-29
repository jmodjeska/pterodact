class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :catalog
      t.text :description
      t.datetime :offer_date
      t.integer :size
      # For currency, create on command line with float, but then change to decimal:
      # t.decimal :cost, precision: 9, scale: 2
      
      t.timestamps
    end
  end
end
