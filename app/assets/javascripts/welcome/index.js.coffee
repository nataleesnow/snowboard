class Index

  constructor: ->
    $(document)
      .on('click', '.supply_wtp', @supplyWtp)
      .on('click', '.save_wtp', @saveWtp)

  saveWtp: (event) =>
    event.preventDefault()
    lift_pass_id = $(event.target).data("liftPassId")
    wtp_number = []
    $.each $(".wtp_"+lift_pass_id), (i, e) ->
      wtp_number.push(e.value) if e.value.match /\w+/
    data = { lift_pass_id: lift_pass_id, wtp_number: wtp_number }
    path = $(event.target).attr("href")
    reqSave(data, path) if validWTP(data.lift_pass_id, data.wtp_number)

  supplyWtp: (event) =>
    event.preventDefault()
    lift_pass_id = $(event.target).parent().data("liftPassId")
    modal = getModal(lift_pass_id)
    modal.foundation('open')

  getModal = (id) ->
    return $('#lp_'+id)

  reqSave = (data,path) ->
    modal = getModal(data.lift_pass_id)
    $.ajax path,
      type: 'GET',
      dataType: 'html',
      data: data,
      success: (data) ->
        modal.foundation('close')
        res = $.parseJSON(data)
        if res.success
          res_txt = "Card was saved!"
          aclass = "success"
        else
          res_txt = res.err
          aclass = "alert"
        $(".callout.notice").addClass(aclass).html(res_txt).show()

  validWTP = (lift_pass_id,wtp) ->
    modal = getModal(lift_pass_id)
    modal.find(".callout.alert").html('').hide()
    if $.isEmptyObject(wtp)
      modal.find(".callout.alert").html('Please enter WTP number.').show() if $.isEmptyObject(wtp)
      return false
    return true

$ ->
  (new Index())
