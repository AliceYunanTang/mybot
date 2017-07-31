require "google/cloud/vision"
require "pry"

vision = Google::Cloud::Vision.new

# image = vision.image "http://www.smh.com.au/content/dam/images/3/y/8/9/4/image.related.articleLeadwide.620x349.ghv4p3.png/1435030602190.jpg"
# imageUrlString = "http://res.cloudinary.com/cloudalice/image/upload/v1501413921/#{@picture.image}"
# imageUrlString = "http://res.cloudinary.com/cloudalice/image/upload/v1501413921/yt2mzvwavwdvhzq7vdlx"
# imageUrlString = "http://res.cloudinary.com/cloudalice/image/upload/v1499942479/cuspd83jpfvrurp0opnu.jpg"
imageUrlString = "https://cdn.pixabay.com/photo/2017/06/20/23/22/plant-2425328_1280.jpg"
# <%= cl_image_tag img.public_id %>
# <%= image_tag 'filename.jpg' %>

binding.pry

# image = vision.image imageUrlString
