class ChangeCompletedDefaultOnTasks < ActiveRecord::Migration
  def change
  	change_column :tasks, :completed, :boolean, :default => null
  end
end
