(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
var BlogCtrl;

Router.map(function() {
  this.route('blogPage', {
    path: 'blog/:alias',
    template: 'blogPage',
    layoutTemplate: 'innerLayout',
    waitOn: function() {
      return Meteor.subscribe('blog');
    },
    data: function() {
      return Blog.findOne({
        alias: this.params.alias
      });
    },
    action: function() {
      if (this.ready()) {
        return this.render();
      }
    }
  });
  return this.route('bloglist', {
    path: 'bloglist',
    layoutTemplate: 'innerLayout',
    template: 'blog',
    waitOn: function() {
      return [Meteor.subscribe('blog'), Meteor.subscribe('blogTags')];
    }
  });
});

if (Meteor.isClient) {
  Meteor.subscribe('blog');
  Meteor.subscribe('blogTags');
  Meteor.subscribe('blogCategories');
  Session.set('auraBlogListCategory', 'all');
  Session.set('auraBlogListSort', 'date');
  Template.registerHelper('blogList', function() {
    var category, query, sortField, sortQuery;
    category = Session.get('auraBlogListCategory');
    sortField = Session.get('auraBlogListSort');
    sortQuery = {};
    query = (function() {
      if (category === 'all') {
        return {};
      } else {
        return {
          category: category
        };
      }
    })();
    sortQuery[sortField] = 1;
    return Blog.find(query, sortQuery);
  });
  Template.registerHelper('blogCategories', function() {
    return BlogCategories.find();
  });
  Template.registerHelper('getBlogDate', function(date) {
    return moment(date).format('DD.MM.YYYY');
  });
  Template.blogCreateModal.rendered = function() {
    Meteor.defer(function() {
      return this.$('#blog-create-modal').addClass('_opened');
    });
    return this.$('select').select2({
      minimumResultsForSearch: -1
    });
  };
  Meteor.startup(function() {
    $('body').on('click', '[data-goto-blog-page]', function(e) {
      var alias;
      console.log($(e.target));
      if ($(e.target).parent('.remove').length === 0) {
        alias = $(e.currentTarget).data('alias');
        return Router.go('blogPage', {
          alias: alias
        });
      }
    });
    $('body').on('click', '[data-aura-blog-remove-tag]', function(e) {
      var recordId, tagId;
      tagId = $(e.currentTarget).closest('[data-tag-id]').data('tag-id');
      recordId = $(e.currentTarget).closest('[data-aura-with]').data('aura-with');
      return Meteor.call('removeTagFromRecord', recordId, tagId, function(err, res) {
        if (err) {
          return console.log(err);
        }
      });
    });
    $('body').on('click', '[data-aura-blog-next]', function(e) {
      var currentId;
      currentId = $(e.currentTarget).closest('[data-aura-with]').data('aura-with');
      return BlogCtrl.nextRecord(currentId);
    });
    $('body').on('click', '[data-aura-blog-prev]', function(e) {
      var currentId;
      currentId = $(e.currentTarget).closest('[data-aura-with]').data('aura-with');
      return BlogCtrl.prevRecord(currentId);
    });
    $('body').on('keypress', '#aura-blog-add-tag', function(e) {
      var id, tagId;
      if (e.which === 13) {
        id = $(e.currentTarget).closest('[data-aura-with]').data('aura-with');
        if (BlogTags.findOne({
          name: $(e.currentTarget).val()
        })) {
          tagId = BlogTags.findOne({
            name: $(e.currentTarget).val()
          })._id;
          if (!_.contains(Blog.findOne({
            _id: id
          }).tags, BlogTags.findOne({
            name: $(e.currentTarget).val()
          })._id)) {
            return Meteor.call('incrementBlogTagCount', $(e.currentTarget).val(), function(err, res) {
              if (err) {
                return console.log(err);
              } else {
                return Meteor.call('addTagToRecord', id, res, function(error, resp) {
                  if (error) {
                    return console.log(error);
                  } else {
                    return $(e.target).val('');
                  }
                });
              }
            });
          } else {
            Aura.notify('Такой тег уже добавлен!');
            return $(e.target).val('');
          }
        } else {
          return Meteor.call('createBlogTag', $(e.currentTarget).val(), function(err, res) {
            if (err) {
              return console.log(err);
            } else {
              return Meteor.call('addTagToRecord', id, res, function(error, resp) {
                if (error) {
                  return console.log(error);
                } else {
                  return $(e.target).val('');
                }
              });
            }
          });
        }
      }
    });
    $('body').on('click', '[data-add-new-blog-page]', function(e) {
      if (!BlogCtrl.addModalTemplate) {
        return BlogCtrl.addModalTemplate = Blaze.render(Template.blogCreateModal, document.body);
      } else {
        return $('#blog-create-modal').addClass('_opened');
      }
    });
    $('body').on('click', '#blog-create-modal button', function(e) {
      var input, select;
      input = $('#blog-create-modal').find('input').val();
      select = $('#blog-create-modal').find('select').val();
      if (input && input !== '') {
        if (!Blog.findOne({
          alias: input
        })) {
          if (!input.split(' ')[1]) {
            $('#blog-create-modal').removeClass('_opened');
            return Meteor.setTimeout(function() {
              return BlogCtrl.addRecord(input, select);
            }, 400);
          } else {
            return Aura.notify('Ссылка должна быть сплошной строкой без пробелов=(');
          }
        } else {
          return Aura.notify('Запись с таким именем уже существует=(');
        }
      } else {
        return Aura.notify('Пожалуйста введите название ссылки на статью');
      }
    });
    $('body').on('click', '.blog-cont .item .remove', function(e) {
      var alias;
      alias = $(e.currentTarget).closest('[data-alias]').data('alias');
      return (new PNotify({
        title: 'Удалить запись?',
        text: 'Возможности восстановить ее уже не будет',
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
        return Meteor.call('removeRecord', alias, function(err, res) {
          if (err) {
            return console.log(err);
          } else {
            return Aura.notify('Запись удалена');
          }
        });
      });
    });
    return $('body').on('click', '#blog-create-modal .remove', function(e) {
      return $('#blog-create-modal').removeClass('_opened');
    });
  });
  BlogCtrl = {
    addModalTemplate: null,
    addRecord: function(alias, category) {
      console.log('adding blog record');
      return Meteor.call('addRecord', alias, category, function(err, res) {
        if (err) {
          return console.log(err);
        } else {
          return Router.go('blogPage', {
            alias: res
          });
        }
      });
    },
    nextRecord: function(currentId) {
      var blogList, index, length, nextId, nextRecordAlias;
      blogList = Blog.find().fetch();
      length = blogList.length;
      index = 0;
      nextId = '';
      blogList.forEach(function(b) {
        if (b._id === currentId) {
          if (index + 1 > length) {
            nextId = blogList[0]._id;
          } else {
            nextId = blogList[index + 1]._id;
          }
        }
        return index++;
      });
      console.log(nextId);
      nextRecordAlias = Blog.findOne({
        _id: nextId
      }).alias;
      return Router.go('blogPage', {
        alias: nextRecordAlias
      });
    },
    prevRecord: function(currentId) {
      var blogList, index, prevId, prevRecordAlias;
      blogList = Blog.find().fetch();
      index = 0;
      prevId = '';
      blogList.forEach(function(b) {
        if (b._id === currentId) {
          if (index - 1 < 0) {
            prevId = _.last(blogList)._id;
          } else {
            prevId = blogList[index - 1]._id;
          }
        }
        return index++;
      });
      console.log(prevId);
      prevRecordAlias = Blog.findOne({
        _id: prevId
      }).alias;
      return Router.go('blogPage', {
        alias: prevRecordAlias
      });
    }
  };
}

if (Meteor.isServer) {
  Meteor.methods({
    addRecord: function(alias, category) {
      if (Roles.userIsInRole(Meteor.user(), ['owner', 'admin'])) {
        Blog.insert({
          alias: alias,
          pic: null,
          title: 'Ваш заголовок',
          date: Date.parse(new Date()),
          shortDesc: 'Краткое описание',
          html: '<p>Напишите что-нибудь=)</p>',
          tags: null
        });
        return alias;
      } else {
        return console.log('permission denied');
      }
    },
    removeRecord: function(alias) {
      return Blog.remove({
        '_id': Blog.findOne({
          alias: alias
        })._id
      });
    },
    addTagToRecord: function(id, tag) {
      console.log('adding tag to record');
      return Blog.update({
        _id: id
      }, {
        $push: {
          tags: tag
        }
      });
    },
    createBlogTag: function(name) {
      console.log('creating auraBlog tag with name: ' + name);
      return BlogTags.insert({
        name: name,
        count: 1
      });
    },
    incrementBlogTagCount: function(name) {
      console.log('incrementing auraBlog tag: ' + name);
      BlogTags.update({
        'name': name
      }, {
        $inc: {
          count: 1
        }
      });
      return BlogTags.findOne({
        'name': name
      })._id;
    },
    removeTagFromRecord: function(recordId, tagId) {
      Blog.update({
        _id: recordId
      }, {
        $pull: {
          tags: tagId
        }
      });
      if (BlogTags.findOne({
        _id: tagId
      }).count > 1) {
        return BlogTags.update({
          _id: tagId
        }, {
          $inc: {
            count: -1
          }
        });
      } else {
        return BlogTags.remove({
          _id: tagId
        });
      }
    }
  });
  Meteor.publish('blog', function() {
    return Blog.find();
  });
  Meteor.publish('blogTags', function() {
    return BlogTags.find();
  });
  Meteor.publish('blogCategories', function() {
    return BlogCategories.find();
  });
  Meteor.startup(function() {
    if (Blog.find().count() === 0) {
      Blog.insert({
        alias: 'new-record',
        pic: 'blog_bg.jpg',
        title: 'Новая классная статья в блоге',
        date: Date.parse(new Date()),
        shortDesc: 'Это короткое описание статьи, его надо заполнять отдельно',
        html: '<p>Новая статья, очень круто и весело, нам все нравится и мы получаем удовольствие. Очень много классного текста, еще больше, еще бооооольше</p><p class="inline-quot">Это цитата, ее можно вставлять в текст динамически, достаточно симпатично смотрится и привлекает внимание, с ее помощью можно выделять важные элементы</p><p>Как же все таки круто нахлдиться в теплой компании, например на Рождество или Новый год, где-нибудь на курорте или что-нибудь такое.</p><img class="aura-float-left" src="http://d1tvqt3gjtui5j.cloudfront.net/images/bal.jpg" data-aura-image-embed alt=""/><p>Это текст для обкатывания того, чтобы посмотреть как картинка выглядит прямо в тексте, вроде непохо.</p>',
        tags: []
      });
      Blog.insert({
        alias: 'new-record-again',
        pic: 'blog_bg.jpg',
        title: 'Новая классная статья в блоге',
        date: Date.parse(new Date()),
        shortDesc: 'Это короткое описание статьи, его надо заполнять отдельно',
        html: '<p>Новая статья, очень круто и весело, нам все нравится и мы получаем удовольствие</p><p>Как же все таки круто нахлдиться в теплой компании</p>',
        tags: []
      });
      Blog.insert({
        alias: 'new-record-yeeeah',
        pic: 'blog_bg.jpg',
        title: 'Новая классная статья в блоге',
        date: Date.parse(new Date()),
        shortDesc: 'Это короткое описание статьи, его надо заполнять отдельно',
        html: '<p>Новая статья, очень круто и весело, нам все нравится и мы получаем удовольствие</p><p>Как же все таки круто нахлдиться в теплой компании</p>',
        tags: []
      });
    }
    if (BlogCategories.find().count() > 0) {
      BlogCategories.find().fetch().forEach(function(b) {
        return BlogCategories.remove(b._id);
      });
    }
    if (BlogCategories.find().count() === 0) {
      BlogCategories.insert({
        name: 'Школа'
      });
      BlogCategories.insert({
        name: 'События'
      });
      return BlogCategories.insert({
        name: 'Обучение'
      });
    }
  });
}

})();

//# sourceMappingURL=blog.coffee.js.map
