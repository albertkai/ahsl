Template.sochi.rendered = ->

  $('.wrap').addClass '_animated'


Template.sochi.events {

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

      title = 'Заявка в Сочи'
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


Template.sochiSlider.rendered = ->

  console.log 'Sochi slider rendered!'

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

  Meteor.setTimeout =>
    @.$('#sochi-slider').find('ul li').first().addClass 'active'

    @.$('#sochi-slider').carousel({
      interval: 6000
    })
  , 200

  @.$('.slider-edit').find('ul').sortable({
    items: 'li:not(.add-slide)'
    stop: (e, ui)->
      SochiCtrl.reorderSlides()
  })

Template.sochiSlider.helpers {

  'sochiSlider': ->

    SochiSlider.find({}, {sort: {order: 1}})

}

Template.sochiSlider.events {

  'click .add-slide': ->

    SochiCtrl.addSlide()

  'click .remove': (e)->

    SochiCtrl.removeSlide(e)

  'click .slider-edit .slide-item': (e)->

    $('#sochi-slider').carousel($(e.currentTarget).index())

  'click #slider-edit-button': ->

    $('.slider-edit').addClass('_opened')

  'click .close-slider-edit': ->

    $('.slider-edit').removeClass('_opened')



}


@SochiCtrl = {

  reorderSlides: ->

    $('.slider-edit').find('ul .slide-item').each ->
      SochiSlider.update {_id: $(this).data('id')}, {$set: {order: $(this).index()}}

  addSlide: ->

    index = SochiSlider.find().count()

    SochiSlider.insert {

      pic: ''
      desc: 'Описание слайда'
      order: index

    }

    $('#sochi-slider').carousel(index)



  removeSlide: (e)->

    $target = $(e.currentTarget).closest('li')
    order = $target.data('order')
    SochiSlider.find().fetch().forEach (s)->
      if s.order > order
        SochiSlider.update {_id: s._id}, {$inc: {order: -1}}
    SochiSlider.remove {_id: $target.data('id')}
    $('#sochi-slider').find('ul li').removeClass('active').first().addClass 'active'
    $('#sochi-slider').carousel({
      interval: 6000
    })


}