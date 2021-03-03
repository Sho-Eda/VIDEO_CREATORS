class CreateReels < ActiveRecord::Migration[5.2]
  def change
    create_table :reels do |t|
      t.string :youtube_url

      t.timestamps
    end
  end
end
