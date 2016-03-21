class Index

  constructor: ->
    $(document)
      .on('click', '.supply_wtp', @supplyWtp)
      .on('click', '.save_wtp', @saveWtp)
      Foundation.Motion.animateIn($("#spinccw"), 'slide-in-right')

  saveWtp: (event) =>
    event.preventDefault()
    target = $(event.target)
    lift_pass_id = target.data("liftPassId")
    wtp_number = []
    $.each $(".wtp_"+lift_pass_id), (i, e) ->
      wtp_number.push(e.value) if e.value.match /\w+/
    data = { lift_pass_id: lift_pass_id, wtp_number: wtp_number }
    path = $(event.target).attr("href")
    reqSave(data, path) if validWTP(data.lift_pass_id, data.wtp_number)

  supplyWtp: (event) =>
    event.preventDefault()
    lift_pass_id = $(event.target).data("liftPassId")
    $("#"+lift_pass_id+"_wtp").toggle()

  reqSave = (data,path) ->
    $.ajax path,
      type: 'GET',
      dataType: 'html',
      data: data,
      success: (data) ->
        res = $.parseJSON(data)
        if res.success
          res_txt = "Card was saved!"
          aclass = "success"
        else
          res_txt = res.err
          aclass = "alert"
        $(".callout.notice").addClass(aclass).html(res_txt).fadeIn(400)
        setTimeout (-> location.reload()), 3000

  validWTP = (lift_pass_id,wtp) ->
    if $.isEmptyObject(wtp)
      $(".callout.alert").html('Please enter WTP number.').show() if $.isEmptyObject(wtp)
      return false
    return true

$ ->
  (new Index())
