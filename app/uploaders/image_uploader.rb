class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  if Rails.env.development?
    storage :fog
  elsif Rails.env.test?
    storage :fog
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args) 
     "default-image.jpg" 
  end 

  def extension_whitelist
    %w(png gif jpg jpeg mp4)
  end

  def size_range
    1..10.megabytes
  end

  def filename
    original_filename if original_filename
  end

 process resize_to_fill: [5000, 5000, "Center"]

 version :thumb do    
  process resize_to_fill: [400,225, "Center"]
end

 version :thumb2 do    
   process resize_to_fill: [840,440, "Center"]
 end
 

end
