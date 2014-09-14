class ChangeDatetimeFormatInTasks < ActiveRecord::Migration
  def change
  	change_column :tasks, :due, :date
  end
end
