class CreateOfferDates < ActiveRecord::Migration
  def change
    create_table :offer_dates do |t|
      t.integer :course_id
      t.datetime :date
      t.integer :size
      t.references :courses, index: true, foreign_key: true
      t.timestamps
    end
  end
end
