class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :barcode, null: false

      t.timestamps
    end
    add_index :tickets, :barcode, unique: true
  end
end
