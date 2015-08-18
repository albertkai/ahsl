Template.country.rendered = ->

  $('.wrap').addClass '_animated'


Template.country.events {

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

      title = 'Заявка в загородную школу'
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


Template.countrySlider.rendered = ->

  console.log 'Country slider rendered!'

  $('#direction-user-phone').inputmask("+7(999)999-99-99")

  Meteor.setTimeout =>
    @.$('#country-slider').find('ul li').first().addClass 'active'

    @.$('#country-slider').carousel({
      interval: 6000
    })
  , 200

  @.$('.slider-edit').find('ul').sortable({
    items: 'li:not(.add-slide)'
    stop: (e, ui)->
      CountryCtrl.reorderSlides()
  })

Template.countrySlider.helpers {

  'countrySlider': ->

    CountrySlider.find({}, {sort: {order: 1}})

}

Template.countrySlider.events {

  'click .add-slide': ->

    CountryCtrl.addSlide()

  'click .remove': (e)->

    CountryCtrl.removeSlide(e)

  'click .slider-edit .slide-item': (e)->

    $('#country-slider').carousel($(e.currentTarget).index())

  'click #slider-edit-button': ->

    $('.slider-edit').addClass('_opened')

  'click .close-slider-edit': ->

    $('.slider-edit').removeClass('_opened')



}


@CountryCtrl = {

  reorderSlides: ->

    $('.slider-edit').find('ul .slide-item').each ->
      CountrySlider.update {_id: $(this).data('id')}, {$set: {order: $(this).index()}}

  addSlide: ->

    index = CountrySlider.find().count()

    CountrySlider.insert {

      pic: ''
      desc: 'Описание слайда'
      order: index

    }

    $('#country-slider').carousel(index)



  removeSlide: (e)->

    $target = $(e.currentTarget).closest('li')
    order = $target.data('order')
    CountrySlider.find().fetch().forEach (s)->
      if s.order > order
        CountrySlider.update {_id: s._id}, {$inc: {order: -1}}
    CountrySlider.remove {_id: $target.data('id')}
    $('#country-slider').find('ul li').removeClass('active').first().addClass 'active'
    $('#country-slider').carousel({
      interval: 6000
    })


}