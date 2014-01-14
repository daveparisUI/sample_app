module UsersHelper
  #Listing 7.29
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = {size: 120})
    #gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
  #gravatar_url = "https://secure.gravatar.com/avatars/#{gravatar_id}.png?s=#{size}"


    gravatar_url = case user.id.to_s[-1, 1].to_i
                     when 2
                       "http://www.daveparis.com/webfotos/logos/reverbnationlogo.png"
                     when 1
                       "http://images.cdbaby.name/d/a/daveparis3_small.jpg"
                     when 3
                       "http://ecx.images-amazon.com/images/I/61WBVB-7ADL._SS135_SL160_.jpg"
                     when 4
                       "http://www.daveparis.com/webfotos/logos/dpchapter.png?s=#{size}"
                     when 5
                       "http://www.daveparis.com/webfotos/logos/fblogo.png?s=#{size}"
                     when 6
                       "http://www.daveparis.com/webfotos/logos/email.png?s=#{size}"
                     when 7
                       "http://a3.mzstatic.com/us/r30/Music/94/96/9a/mzi.qmdmbres.100x100-75.jpg"
                     when 8
                       "http://www.daveparis.com/webfotos/logos/hoopla.png?s=#{size}"
                     else
                       "http://www.daveparis.com/webfotos/logos/youtubelogo.png?s=#{size}"
                   end
    image_tag(gravatar_url, alt: user.name, class: "gravatar", :size => "#{size}x#{size}")
  end

end
