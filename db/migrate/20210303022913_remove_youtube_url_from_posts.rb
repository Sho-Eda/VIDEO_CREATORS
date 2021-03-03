class RemoveYoutubeUrlFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :youtube_url, :string
  end
end
