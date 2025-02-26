module LibraryResourcesHelper
  def resource_image_url(resource)
    case resource.title
    when "War and Peace"
      "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1413215930i/656.jpg"
    when "Pride and Prejudice"
      "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1320399351i/1885.jpg"
    when "Dune"
      "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1555447414i/44767458.jpg"
    when "1984"
      "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1657781256i/61439040.jpg"
    when "The Great Gatsby"
      "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1490528560i/4671.jpg"
    when "National Geographic"
      "https://www.nationalgeographic.com/content/dam/ngdotcom/rights-exempt/homepage/nationalgeographicmagazinecovers/01_nationalgeographicmagazinecover.adapt.1900.1.jpg"
    when "Scientific American"
      "https://www.scientificamerican.com/store/images/sa-covers/201801.jpg"
    when "Historical Review"
      "https://www.historians.org/Images/Publications%20and%20Directories/AHR/AHR-Cover-April-2023.jpg"
    when "Nature"
      "https://media.springernature.com/w440/springer-static/cover-hires/journal/41586/619/7885"
    when "Time Magazine"
      "https://api.time.com/wp-content/uploads/2024/01/TIM240122_Biden.Trump_.Cover_.jpg"
    else
      "https://via.placeholder.com/300x400"
    end
  end
end
