Template.blog.rendered = ->

  Meteor.defer ->
    $('.wrap').addClass '_animated'

  $.stellar()

  $('#blog aside').scrollToFixed({
    marginTop: 135,
    postFixed: (e)->
      Meteor.defer ->
        $(e.target).css('top', '50px')
  })

  $('body').css({'position', 'relative'}).scrollspy({ target: '.blog-nav', offset: 80 })

  $('body').on 'activate.bs.scrollspy', ->
    target = $('.blog-nav').find('li.active a').attr('href')
    console.log target
    $('.blog-cont').find('article').removeClass('active')
    $(target).addClass('active')

Template.blog.events {

  'click .blog-nav a': (e)->

    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    $('body').scrollTo $(target), 600, {offset: -70}

}