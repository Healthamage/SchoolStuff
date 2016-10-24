class CreateTelephones < ActiveRecord::Migration[5.0]
  def change
    create_table :telephones do |t|
      t.string :phonenumber
      t.string :email
      t.belongs_to :contact, index: true, foreign_key: true

      t.timestamps
    end
  end
end
