module WelcomeHelper
  def link_to_lift_pass(lift_pass)
    img = image_tag("wtp_number.jpg", class: "thumbnail small-thumb")
    return link_to img, lift_pass_path(lift_pass.id) #if lift_pass.wtp_number.present?
  end

end
