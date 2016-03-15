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
    })

$ ->
  (new Index())
