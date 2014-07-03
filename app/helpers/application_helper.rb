module ApplicationHelper
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  def has_licenses(place)
    bool = false
    unless place.photos.blank?
      place.photos.each {|photo| bool = true unless photo.license_text.blank? }
    end
  end
  def app_store_url
    "https://itunes.apple.com/us/app/camphero-michigan-campground/id889639762"
  end
end
