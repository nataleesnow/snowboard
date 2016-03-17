class Index

  constructor: ->

    $(document).ready ->
      Foundation.Motion.animateIn($("#vert"), 'spin-in')
      Foundation.Motion.animateIn($("#total"), 'scale-in-down')
      Foundation.Motion.animateIn($("#spinccw"), 'slide-in-right')
      $("#left_icon").delay(2000).slideDown()
      $("#right_icon").delay(2000).slideDown()

    $('.day').magnificPopup({
        type:'ajax',
        fixedContentPos: false,
        fixedBgPos: true,
        overflowY: 'auto',
        closeBtnInside: true,
        preloader: false,
        midClick: true,
        removalDelay: 300,
        mainClass: 'mfp-zoom-in'
    })

$ ->
  (new Index())
