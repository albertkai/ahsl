Template.innerLayout.rendered = ->

  $('.fixed-nav').waypoint (dir)->

    if dir is 'up'
      $(this).removeClass '_fixed'
    else if dir is 'down'
      $(this).addClass '_fixed'