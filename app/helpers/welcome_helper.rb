module WelcomeHelper
  def link_to_lift_pass(lift_pass)
    img = image_tag("wtp_number.jpg", class: "thumbnail")
    return link_to img, rider_data_path(lift_pass.owner.id) if lift_pass.wtp_number.present?
    return link_to img, '', class: "supply_wtp", data: {"lift_pass_id": lift_pass.id}
  end

end
