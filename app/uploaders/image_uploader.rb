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
    %w(png gif jpg jpeg MOV wmv mp4)
  end

  # def size_range
  #   1..1000.megabytes
  # end

  def filename
    original_filename if original_filename
  end

 process resize_to_fill: [1920, 1080, "Center"]

version :thumb do    
  process resize_to_fill: [400,225, "Center"]
end

 version :thumb2 do    
   process resize_to_fill: [640,360, "Center"]
 end


# ファイル名をランダム英数字に
def filename
  "#{secure_token}.#{file.extension}" if original_filename.present?
end
def secure_token
  var = :"@#{mounted_as}_secure_token"
  model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
end


 

end
