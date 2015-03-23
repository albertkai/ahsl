(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
var initial;

if (Meteor.isClient) {
  console.log('Aura::Gallery initialized!');
  Meteor.subscribe('auraGallery');
  initial = true;
  Tracker.autorun(function() {
    console.log('tracker runned');
    if (AuraGallery.findOne()) {
      if (initial) {
        Session.set('auraGalleryCurrentAlbum', AuraGallery.findOne()._id);
        return initial = false;
      }
    }
  });
  Tracker.autorun(function() {
    if (AuraGallery.findOne()) {
      console.log('tracker 2 runed');
      Session.set('auraGalleryCurrentPic', AuraGallery.findOne({
        '_id': Session.get('auraGalleryCurrentAlbum')
      }).pics[0]);
      return Gallery.countPreviewTape();
    }
  });
  Template.registerHelper('auraGalleryListAlbums', function() {
    return AuraGallery.find({}, {
      sort: {
        order: 1
      }
    });
  });
  Template.registerHelper('auraGalleryCurrentAlbum', function() {
    if (Session.get('auraGalleryCurrentAlbum')) {
      console.log(Session.get('auraGalleryCurrentAlbum'));
      return AuraGallery.findOne({
        '_id': Session.get('auraGalleryCurrentAlbum')
      });
    }
  });
  Template.registerHelper('auraGalleryCurrentPic', function() {
    $('<img>').attr('src', 'http://d1tvqt3gjtui5j.cloudfront.net/gallery/' + Session.get('auraGalleryCurrentPic')).on('load', function() {
      $('.main-pic').find('.spinner-container').removeClass('_visible');
      return $('.pic-container').addClass('_visible');
    });
    return Session.get('auraGalleryCurrentPic');
  });
  Template.registerHelper('auraGalleryGetThumb', function(pic) {
    if (pic) {
      return pic.split('.')[0] + '_thumb.' + pic.split('.')[1];
    }
  });
  Template.registerHelper('getFirstPicThumb', function(pics) {
    var pic;
    pic = _.first(pics);
    return pic.split('.')[0] + '_thumb.' + pic.split('.')[1];
  });
  Meteor.startup(function() {
    $('body').on('click', '[data-gallery-album-target]', function(e) {
      var target;
      console.log('changing album');
      if ($(e.currentTarget).data('gallery-album-target') !== Session.get('auraGalleryCurrentAlbum')) {
        target = $(e.currentTarget).data('gallery-album-target');
        console.log(target);
        $('.main-pic').find('.spinner-container').addClass('_visible');
        $('.pic-container').removeClass('_visible');
        return Session.set('auraGalleryCurrentAlbum', target);
      } else {
        return $.scrollTo('.pic-container', 600, {
          offset: -70
        });
      }
    });
    $('body').on('click', '[data-gallery-toggle-modal]', function() {
      console.log('gallery admin rendered');
      if (Gallery.galleryEditModal) {
        return $('#galleryEditModal').addClass('_opened');
      } else {
        return Gallery.galleryEditModal = Blaze.renderWithData(Template.galleryEditModal, {
          itemList: AuraGallery.find({}, {
            sort: {
              order: 1
            }
          })
        }, document.body);
      }
    });
    $('body').on('click', '[data-gallery-pic-target]', function(e) {
      var target;
      console.log('changing pic');
      if ($(e.currentTarget).data('gallery-pic-target') !== Session.get('auraGalleryCurrentPic')) {
        target = $(e.currentTarget).data('gallery-pic-target');
        console.log(target);
        $('.main-pic').find('.spinner-container').addClass('_visible');
        $('.pic-container').removeClass('_visible');
        Session.set('auraGalleryCurrentPic', target);
        return $(e.currentTarget).addClass('_active').siblings().removeClass('_active');
      }
    });
    $('body').on('click', '#auraGalleryNextPic', function() {
      var length, picIndex;
      length = AuraGallery.findOne({
        '_id': Session.get('auraGalleryCurrentAlbum')
      }).pics.length;
      $('.main-pic').find('.spinner-container').addClass('_visible');
      $('.pic-container').removeClass('_visible');
      picIndex = (function() {
        var index;
        if ($('.carousel-container').find('div._active').length > 0) {
          index = $('.carousel-container').find('div._active').index();
          if (index + 1 >= length) {
            $('.carousel-container').find('div._active').removeClass('_active');
            $('.carousel-container').find('div').first().addClass('_active');
            return 0;
          } else {
            index + 1;
            $('.carousel-container').find('div._active').removeClass('_active').next().addClass('_active');
            return $('.carousel-container').find('div._active').index();
          }
        } else {
          $('.carousel-container').find('div').first().next().addClass('_active');
          return 1;
        }
      })();
      return Session.set('auraGalleryCurrentPic', AuraGallery.findOne({
        '_id': Session.get('auraGalleryCurrentAlbum')
      }).pics[picIndex]);
    });
    return $('body').on('click', '#auraGalleryPrevPic', function() {
      var length, picIndex;
      length = AuraGallery.findOne({
        '_id': Session.get('auraGalleryCurrentAlbum')
      }).pics.length;
      $('.main-pic').find('.spinner-container').addClass('_visible');
      $('.pic-container').removeClass('_visible');
      picIndex = (function() {
        var index;
        if ($('.carousel-container').find('div._active').length > 0) {
          index = $('.carousel-container').find('div._active').index();
          if (index - 1 < 0) {
            $('.carousel-container').find('div._active').removeClass('_active');
            $('.carousel-container').find('div').last().addClass('_active');
            return $('.carousel-container').find('div').last().index();
          } else {
            index - 1;
            $('.carousel-container').find('div._active').removeClass('_active').prev().addClass('_active');
            return $('.carousel-container').find('div._active').index();
          }
        } else {
          $('.carousel-container').find('div').last().addClass('_active');
          return $('.carousel-container').find('div').last().index();
        }
      })();
      return Session.set('auraGalleryCurrentPic', AuraGallery.findOne({
        '_id': Session.get('auraGalleryCurrentAlbum')
      }).pics[picIndex]);
    });
  });
  Template.galleryEditModal.events({
    'click aside li': function(e) {
      var id;
      id = $(e.currentTarget).data('id');
      Session.set('auraModalList', id);
      $(e.currentTarget).addClass('_active').siblings().removeClass('_active');
      if (Gallery.currentEditModalAlbum) {
        Blaze.remove(Gallery.currentEditModalAlbum);
      }
      console.log(AuraGallery.findOne({
        _id: id
      }));
      return Gallery.currentEditModalAlbum = Blaze.renderWithData(Template.galleryEditModalAlbum, AuraGallery.findOne({
        _id: id
      }), $('#galleryEditModal').find('.list-wrap').get(0));
    },
    'click aside li .delete': function(e) {
      var clicked, id, images, order, thumbs;
      clicked = $(e.target).closest('li');
      id = clicked.data('id');
      images = AuraGallery.findOne({
        '_id': id
      }).pics;
      thumbs = images.map(function(i) {
        return i.split('.')[0] + '_thumb.' + i.split('.')[1];
      });
      images = images.concat(thumbs);
      order = parseInt(clicked.data('order'), 10);
      console.log(images);
      return (new PNotify({
        title: 'Удалить целый альбом?',
        text: 'Все фотографии этого альбома будут удалены с хостинга',
        hide: false,
        addclass: 'aura-notify',
        confirm: {
          confirm: true
        },
        buttons: {
          closer: false,
          sticker: false
        },
        history: {
          history: false
        }
      })).get().on('pnotify.confirm', function() {
        return Meteor.call('deletePics', images, 'ahsl2/gallery', function(err, res) {
          if (err) {
            return Aura.notify('Изображения не удалены:( Может и к лучшему))');
          } else {
            if (res) {
              AuraGallery.remove(id);
              Aura.notify('Альбом удален!');
              $(e.target).closest('ul').find('li').first().trigger('click');
              return AuraGallery.find({
                order: {
                  $gt: order
                }
              }).fetch().forEach(function(album) {
                var newOrder;
                newOrder = album.order - 1;
                id = album._id;
                return AuraGallery.update(id, {
                  $set: {
                    order: newOrder
                  }
                });
              });
            } else {
              return Aura.notify('Изображения не удалены:( Ошибка на стороне сервера');
            }
          }
        });
      }).on('pnotify.cancel', function() {
        return console.log('deletion canceled');
      });
    },
    'click aside .add-new': function(e) {
      AuraGallery.find().fetch().forEach(function(album) {
        var newOrder;
        newOrder = album.order + 1;
        console.log(newOrder);
        return AuraGallery.update(album._id, {
          $set: {
            order: newOrder
          }
        });
      });
      return AuraGallery.insert({
        order: 0,
        pics: [],
        title: 'Новый альбом',
        desc: 'Описание альбома',
        date: Date.parse(new Date())
      }, function(id) {
        return Meteor.setTimeout(function() {
          return $(e.target).siblings('ul').find('li').first().trigger('click');
        }, 300);
      });
    }
  });
  Template.galleryEditModal.rendered = function() {
    console.log('rendering gallery admin');
    return Meteor.defer(function() {
      $('#galleryEditModal').addClass('_opened');
      $('#galleryEditModal').find('#gallery-albums-list').sortable({
        stop: function(e, ui) {
          return Gallery.reorderAlbums();
        }
      });
      return $('#galleryEditModal').find('#gallery-albums-list').find('li').first().trigger('click');
    });
  };
  Template.galleryEditModalAlbum.rendered = function() {
    return $("#gallery-items-thumbs").sortable({
      stop: function(e, ui) {
        return Gallery.reorderPics();
      }
    });
  };
  Template.galleryEditModalAlbum.helpers({
    getThumb: function(pic) {
      return pic.split('.')[0] + '_thumb.' + pic.split('.')[1];
    }
  });
  Template.galleryEditModalAlbum.events({
    'change .add input[type="file"]': function(e) {
      var file, fr, id, input;
      console.log('triggered change');
      input = $(e.target);
      file = input.get(0).files[0];
      console.log(input.get(0).files[0]);
      id = $('#albumId').val();
      fr = new FileReader();
      NProgress.start();
      return Aura.media.resizeAndUpload(id, file, function(res) {
        var albumId;
        albumId = $('#albumId').val();
        return AuraGallery.update({
          _id: albumId
        }, {
          $push: {
            pics: res
          }
        }, function() {
          NProgress.done();
          $('#galleryEditModal').find('#gallery-albums-list').find('li._active').trigger('click');
          return Aura.notify('Изображение добавлено!');
        });
      });
    },
    'dragover .list-cont': function(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      $(e.currentTarget).addClass('_hover');
      return false;
    },
    'dragenter .list-cont': function(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      $(e.currentTarget).addClass('_hover');
      return false;
    },
    'dragleave .list-cont': function(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      $(e.currentTarget).removeClass('_hover');
      return false;
    },
    'drop .list-cont': function(e) {
      var albumId, i, length, uploaded, _i, _results;
      e.preventDefault();
      console.log('triggering multiple upload');
      uploaded = false;
      albumId = $('#albumId').val();
      length = e.originalEvent.dataTransfer.files.length;
      console.log(length);
      NProgress.start();
      _results = [];
      for (i = _i = 0; 0 <= length ? _i < length : _i > length; i = 0 <= length ? ++_i : --_i) {
        console.log('Загружаем ' + (i + 1) + ' файл из ' + length);
        _results.push(Aura.media.resizeAndUpload(albumId, e.originalEvent.dataTransfer.files[i], function(res) {
          return AuraGallery.update({
            _id: albumId
          }, {
            $push: {
              pics: res
            }
          }, function() {
            console.log('изображение ' + res + ' загружено');
            if (i + 1 >= length) {
              NProgress.done();
              $('#galleryEditModal').find('#gallery-albums-list').find('li._active').trigger('click');
              return Aura.notify('Все изображения загружены');
            }
          });
        }));
      }
      return _results;
    },
    'click #gallery-items-thumbs li .delete': function(e) {
      var clicked, id, image, thumb;
      clicked = $(e.target).closest('li');
      id = $('#albumId').val();
      image = _.last(clicked.find('.img').css('background-image').split('/')).replace(')', '');
      thumb = image.split('.')[0] + '_thumb.' + image.split('.')[1];
      console.log(image);
      return Meteor.call('deletePics', [image, thumb], 'ahsl2/gallery', function(err, res) {
        var images;
        if (err) {
          return Aura.notify('Изображение не удалено:( Может и к лучшему))');
        } else {
          if (res) {
            clicked.remove();
            images = [];
            $('#galleryEditModal').find('.list-cont li.item').each(function() {
              var ext, img, name, origName;
              if (!$(this).hasClass('ui-sortable-placeholder')) {
                img = $(this).find('.img').css('background-image').split('/');
                name = _.last(img).replace(')', '');
                ext = _.last(name.split('.'));
                origName = _.first(name.split('.')[0].split('_'));
                return images.push(origName + '.' + ext);
              }
            });
            AuraGallery.update(id, {
              $set: {
                'pics': images
              }
            });
            return Aura.notify('Изображение удалено!');
          } else {
            return Aura.notify('Изображение не удалено:( Ошибка на стороне сервера');
          }
        }
      });
    }
  });
  this.Gallery = {
    galleryEditModal: null,
    currentEditModalAlbum: null,
    countPreviewTape: function() {
      var length, width;
      width = 116;
      length = AuraGallery.findOne({
        '_id': Session.get('auraGalleryCurrentAlbum')
      }).pics.length;
      return $('.list-pics').find('.carousel-container').width(length * width);
    },
    reorderAlbums: function() {
      var newOrder;
      newOrder = [];
      $('#galleryEditModal').find('aside li').each(function() {
        var obj;
        obj = {
          id: $(this).data('id'),
          index: $(this).index()
        };
        return newOrder.push(obj);
      });
      newOrder.forEach(function(item) {
        console.log('updating ' + item.id);
        return AuraGallery.update({
          '_id': item.id
        }, {
          $set: {
            'order': item.index
          }
        });
      });
      return console.log('albums reordered');
    },
    reorderPics: function() {
      var id, reordered;
      reordered = [];
      id = $('#albumId').val();
      $('#galleryEditModal').find('.list-cont li.item').each(function() {
        var ext, img, name, origName;
        if (!$(this).hasClass('ui-sortable-placeholder')) {
          img = $(this).find('.img').css('background-image').split('/');
          name = _.last(img).replace(')', '').replace('"', '');
          ext = _.last(name.split('.'));
          origName = _.first(name.split('.')[0].split('_'));
          return reordered.push(origName + '.' + ext);
        }
      });
      console.log(reordered);
      AuraGallery.update({
        _id: id
      }, {
        $set: {
          'pics': reordered
        }
      }, function() {
        return $('.carousel-cont').find('[data-id="' + id + '"]').trigger('click');
      });
      return console.log('reordered');
    }
  };
}

if (Meteor.isServer) {
  console.log('Aura::Gallery initialized!');
  Meteor.publish('auraGallery', function() {
    return AuraGallery.find();
  });
  if (AuraGallery.find().count() === 0) {
    AuraGallery.insert({
      pics: ['1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg'],
      titlePic: '1.jpg',
      title: 'Фотосессия',
      desc: 'Классная фотосессия для маленьких принцесс',
      date: Date.parse(new Date()),
      order: 1
    });
    AuraGallery.insert({
      pics: ['11.jpg', '12.jpg', '13.jpg', '14.jpg', '15.jpg'],
      titlePic: '11.jpg',
      title: 'Еще событие',
      desc: 'Классная фотосессия для маленьких принцесс',
      date: Date.parse(new Date()),
      order: 2
    });
  }
}

})();

//# sourceMappingURL=gallery.coffee.js.map
