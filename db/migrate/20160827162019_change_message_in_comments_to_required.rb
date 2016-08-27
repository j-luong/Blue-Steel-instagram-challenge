class ChangeMessageInCommentsToRequired < ActiveRecord::Migration[5.0]
  def change
    change_column_null :comments, :message, false
  end
end
