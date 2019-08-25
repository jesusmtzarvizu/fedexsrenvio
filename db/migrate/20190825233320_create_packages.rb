class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table:packages do |t|
      t.string "tracking_number", :limit => 50  
      t.string "fcarrier", :limit => 30  
      t.string "flength", :limit => 10
      t.string "fwidth", :limit => 10
      t.string "fheight", :limit => 10
      t.string "fweight", :limit => 10
      t.string "fdistance_unit", :limit => 10
      t.string "fmass_unit", :limit => 10
      t.string "jlength", :limit => 10
      t.string "jwidth", :limit => 10
      t.string "jheight", :limit => 10
      t.string "jweight", :limit => 10
      t.string "jdistance_unit", :limit => 10
      t.string "jmass_unit", :limit => 10
      t.string "eweight", :limit => 10
      t.timestamps  
    end
  end
end
