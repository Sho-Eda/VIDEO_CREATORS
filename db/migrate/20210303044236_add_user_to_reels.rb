class AddUserToReels < ActiveRecord::Migration[5.2]
  def change
    add_reference :reels, :user, foreign_key: true
  end
end
