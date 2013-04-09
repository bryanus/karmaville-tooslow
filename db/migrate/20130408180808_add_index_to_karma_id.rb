class AddIndexToKarmaId < ActiveRecord::Migration
  def change
  	add_index :karma_points, :user_id
  end
end
