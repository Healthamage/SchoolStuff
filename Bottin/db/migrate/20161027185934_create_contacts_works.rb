class CreateContactsWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts_works do |t|
      t.belongs_to :contact, index: true, foreign_key: true
      t.belongs_to :work, index: true, foreign_key: true
      t.timestamps
    end
  end
end
