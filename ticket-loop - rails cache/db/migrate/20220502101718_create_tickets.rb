class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.text :code
      t.text :owner
      t.text :state

      t.timestamps
    end
  end
end
