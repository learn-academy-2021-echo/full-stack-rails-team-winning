class ChangeContentFromStringToText < ActiveRecord::Migration[6.1]
  def change
    change_column :blogs, :content, :text
  end
end
