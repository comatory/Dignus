class AddAvatarToUser < ActiveRecord::Migration
  def change
    def up
      add_attachment :users, :avatar
    end

    def down
      remove_attachment :users, :avatar
    end
  end
end
