class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.datetime :sent_to_print_at
      t.timestamps
    end
  end
end
