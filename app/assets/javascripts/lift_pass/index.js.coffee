class Index

  constructor: ->

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
        gallery: {
          enabled: true,
          preload: [0,1]
        }

    })

    Foundation.Motion.animateIn($("#vert"), 'spin-in')
    Foundation.Motion.animateIn($("#total"), 'scale-in-down')
    $("#left_icon").delay(1500).slideDown()
    $("#right_icon").delay(1500).slideDown()

$ ->
  (new Index())
