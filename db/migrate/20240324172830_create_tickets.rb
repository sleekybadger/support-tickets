class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :name, null: false, index: true
      t.string :email, null: false, index: true
      t.string :status, null: false, index: true
      t.string :subject, null: false, index: true

      t.text :content

      t.timestamps
    end
  end
end
