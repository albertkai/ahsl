Template.summer.rendered = ->

  $('.wrap').addClass '_animated'


Template.summer.events {

  'click #send-request': (e)->
    group = $(e.currentTarget).data('group')
    $('.custom-modal').addClass('_visible')
    $('.modal-overlay').addClass('_visible')

  'click #send': (e)->

    re = re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    if $('#event-user-name').val() isnt '' and $('#event-user-phone').val() isnt '' and re.test($('#event-user-email').val())

      if $('#event-user-name').val() is ''
        $('#event-user-name').addClass '_invalid'
      else
        $('#event-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#event-user-email').val())
        $('#event-user-email').addClass '_invalid'
      else
        $('#event-user-email').removeClass('_invalid').addClass '_valid'
      if $('#event-user-phone').val() is ''
        $('#event-user-phone').addClass '_invalid'
      else
        $('#event-user-phone').removeClass('_invalid').addClass '_valid'

      title = 'Заявка в летний лагерь'
      name = $('#event-user-name').val()
      phone = $('#event-user-phone').val()
      email = $('#event-user-email').val()

      Meteor.call 'addRequest', title, name, phone, email, (err, res)->

        if err
          console.log err
        else

          text = 'Имя: ' + name + ' \n Телефон: ' + phone + ' \n' + ' Почта: ' + email

          Meteor.call 'sendRequestEmail', title, text, (error, response)->

            if err
              console.log err
            else
              $('.custom-modal').addClass('_shifted')
              $('.sccss').addClass('_shifted')
              Meteor.setTimeout ->
                $('.custom-modal').removeClass('_shifted').removeClass('_visible')
                $('.sccss').removeClass('_shifted')
                $('.modal-overlay').removeClass '_visible'
              , 2000

    else

      if $('#event-user-name').val() is ''
        $('#event-user-name').addClass '_invalid'
      else
        $('#event-user-name').removeClass('_invalid').addClass '_valid'
      if !re.test($('#event-user-email').val())
        $('#event-user-email').addClass '_invalid'
      else
        $('#event-user-email').removeClass('_invalid').addClass '_valid'
      if $('#event-user-phone').val() is ''
        $('#event-user-phone').addClass '_invalid'
      else
        $('#event-user-phone').removeClass('_invalid').addClass '_valid'

}


Template.summerSlider.rendered = ->

  console.log 'Summer slider rendered!'

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

  Meteor.setTimeout =>
    @.$('#summer-slider').find('ul li').first().addClass 'active'

    @.$('#summer-slider').carousel({
        interval: 6000
      })
  , 200

  @.$('.slider-edit').find('ul').sortable({
    items: 'li:not(.add-slide)'
    stop: (e, ui)->
      SummerCtrl.reorderSlides()
  })

Template.summerSlider.helpers {

  'summerSlider': ->

    SummerSlider.find({}, {sort: {order: 1}})

}

Template.summerSlider.events {

  'click .add-slide': ->

    SummerCtrl.addSlide()

  'click .remove': (e)->

    SummerCtrl.removeSlide(e)

  'click .slider-edit .slide-item': (e)->

    $('#summer-slider').carousel($(e.currentTarget).index())

  'click #slider-edit-button': ->

    $('.slider-edit').addClass('_opened')

  'click .close-slider-edit': ->

    $('.slider-edit').removeClass('_opened')



}


@SummerCtrl = {

  reorderSlides: ->

    $('.slider-edit').find('ul .slide-item').each ->
      SummerSlider.update {_id: $(this).data('id')}, {$set: {order: $(this).index()}}

  addSlide: ->

    index = SummerSlider.find().count()

    SummerSlider.insert {

      pic: ''
      desc: 'Описание слайда'
      order: index

    }

    $('#summer-slider').carousel(index)



  removeSlide: (e)->

    $target = $(e.currentTarget).closest('li')
    order = $target.data('order')
    SummerSlider.find().fetch().forEach (s)->
      if s.order > order
        SummerSlider.update {_id: s._id}, {$inc: {order: -1}}
    SummerSlider.remove {_id: $target.data('id')}
    $('#summer-slider').find('ul li').removeClass('active').first().addClass 'active'
    $('#summer-slider').carousel({
      interval: 6000
    })


}