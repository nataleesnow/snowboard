module WelcomeHelper
  def link_to_lift_pass(lift_pass)
    img = image_tag("wtp_number.jpg", class: "thumbnail small-thumb")
    return link_to img, lift_pass_path(lift_pass.id) if lift_pass.wtp_number.present?
    return link_to img, '', class: "supply_wtp", data: {"lift_pass_id": lift_pass.id}, id: "supply_#{lift_pass.id}"
  end

end
