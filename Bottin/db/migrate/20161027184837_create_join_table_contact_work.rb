class CreateJoinTableContactWork < ActiveRecord::Migration[5.0]
  def change
    create_join_table :works, :contacts do |t|
      # t.index [:work_id, :contact_id]
      # t.index [:contact_id, :work_id]
    end
  end
end
