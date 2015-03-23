(function () {

/* Imports */
var Meteor = Package.meteor.Meteor;
var Roles = Package['alanning:roles'].Roles;
var _ = Package.underscore._;
var MongoInternals = Package.mongo.MongoInternals;
var Mongo = Package.mongo.Mongo;
var Accounts = Package['accounts-base'].Accounts;
var WebApp = Package.webapp.WebApp;
var main = Package.webapp.main;
var WebAppInternals = Package.webapp.WebAppInternals;
var Log = Package.logging.Log;
var Tracker = Package.deps.Tracker;
var Deps = Package.deps.Deps;
var DDP = Package.livedata.DDP;
var DDPServer = Package.livedata.DDPServer;
var Blaze = Package.ui.Blaze;
var UI = Package.ui.UI;
var Handlebars = Package.ui.Handlebars;
var Spacebars = Package.spacebars.Spacebars;
var check = Package.check.check;
var Match = Package.check.Match;
var Random = Package.random.Random;
var EJSON = Package.ejson.EJSON;
var HTML = Package.htmljs.HTML;

/* Package-scope variables */
var __coffeescriptShare;

(function () {

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                    //
// packages/aura:core/lib/collections.coffee.js                                                                       //
//                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                      //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
this.AuraColl = {};

this.AuraHistory = new Mongo.Collection('auraHistory');

this.AuraPages = new Mongo.Collection('auraPages');

this.AuraLogs = new Mongo.Collection('auraLogs');

this.AuraSettings = new Mongo.Collection('auraSettings');

AuraColl['auraHistory'] = AuraHistory;

AuraColl['auraPages'] = AuraPages;

AuraColl['auraLogs'] = AuraLogs;

AuraColl['auraSettings'] = AuraSettings;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                    //
// packages/aura:core/client/aura.coffee.js                                                                           //
//                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                      //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
if (Meteor.isClient) {
  console.log('aura is working');
  Session.setDefault('admin.editMode', false);
  AuraColl['users'] = Meteor.users;
  Meteor.subscribe('users');
  Meteor.subscribe('auraPages');
  Meteor.subscribe('auraHistory');
  Template.registerHelper('common', function() {
    return AuraPages.findOne({
      name: 'common'
    });
  });
  Template.registerHelper('index', function() {
    return AuraPages.findOne({
      name: 'index'
    });
  });
  Template.registerHelper('userIsAdmin', function() {
    return Roles.userIsInRole(Meteor.userId(), ['owner', 'admin']);
  });
  Template.registerHelper('contacts', function() {
    return AuraPages.findOne({
      name: 'contacts'
    });
  });
  Template.registerHelper('summer', function() {
    return AuraPages.findOne({
      name: 'summer'
    });
  });
  Template.registerHelper('children', function() {
    return AuraPages.findOne({
      name: 'children'
    });
  });
  Template.registerHelper('teens', function() {
    return AuraPages.findOne({
      name: 'teens'
    });
  });
  Template.registerHelper('lateTeens', function() {
    return AuraPages.findOne({
      name: 'lateTeens'
    });
  });
  Template.registerHelper('grownUps', function() {
    return AuraPages.findOne({
      name: 'grownUps'
    });
  });
  Template.registerHelper('international', function() {
    return AuraPages.findOne({
      name: 'international'
    });
  });
  Template.registerHelper('eventsList', function() {
    return AuraPages.findOne({
      name: 'events'
    });
  });
  Template.registerHelper('inputInstantGetDate', function(date) {
    return moment(date).lang('ru').format('YYYY-MM-DD');
  });
  Template.registerHelper('getDate', function(date) {
    return moment(date).lang('ru').format('DD.MM.YYYY, hh:mm');
  });
  Template.registerHelper('history', function() {
    return AuraHistory.find({}, {
      sort: {
        date: -1
      }
    });
  });
  Template.registerHelper('auraCheckboxIsChecked', function(value) {
    if (value) {
      return 'checked';
    } else {
      return '';
    }
  });
  Template.registerHelper('storagePath', function() {
    return 'http://d1tvqt3gjtui5j.cloudfront.net';
  });
  Meteor.startup(function() {
    $('body').on('click', '.close-modal', function() {
      return $('.auraModal').removeClass('_opened');
    });
    $('body').on('mouseenter', '[data-aura-html][contenteditable="true"]', function(e) {
      var target;
      target = $(e.currentTarget);
      target.addClass('_editor-hover');
      return Meteor.setTimeout(function() {
        return target.removeClass('_editor-hover');
      }, 600);
    });
    Deps.autorun(function() {
      console.log('session worked!');
      if (Session.get('admin.editMode') === true) {
        return $('[contenteditable]').each(function() {
          return $(this).attr('contenteditable', 'true');
        });
      } else {
        return $('[contenteditable]').each(function() {
          return $(this).attr('contenteditable', 'false');
        });
      }
    });
    $('body').on('click', '.logout', function() {
      return Meteor.logout();
    });
    $('body').find('.aura-toggle-edit').on('click', function(e) {
      console.log('changed');
      console.log($(e.currentTarget));
      $(e.currentTarget).toggleClass('_active');
      if ($(e.currentTarget).hasClass('_active')) {
        Session.set('admin.editMode', true);
        return $(e.currentTarget).find('p').text('правка');
      } else {
        Session.set('admin.editMode', false);
        return $(e.currentTarget).find('p').text('просмотр');
      }
    });
    Mousetrap.bind('q w e', function(e) {
      return Aura.showAdminModal();
    });
    Mousetrap.bind('й ц у', function(e) {
      return Aura.showAdminModal();
    });
    Mousetrap.bind(['ctrl+shift+e', 'command+shift+e', 'ctrl+shift+у', 'ctrl+shift+у'], function(e) {
      return Aura.toggleEditMode();
    });
    Mousetrap.bind(['ctrl+shift+s', 'command+shift+s', 'ctrl+shift+ы', 'ctrl+shift+ы'], function(e) {
      $(editor.editingItemSelector).trigger('blur');
      return $('.editor').find('#b-save').trigger('click');
    });
    Template.auraAdminPanel.events({
      'mouseleave #history-cont li': function(e) {
        if (Aura.historyDiffTimeout) {
          Meteor.clearTimeout(Aura.historyDiffTimeout);
        }
        return $('.aura-diff-cont').remove();
      },
      'mouseenter #history-cont li': function(e) {
        if (Aura.historyDiffTimeout) {
          Meteor.clearTimeout(Aura.historyDiffTimeout);
        }
        return Aura['historyDiffTimeout'] = Meteor.setTimeout(function() {
          var changedData, data, diff, item, markup, selectorPath;
          Aura['diff'] = new diff_match_patch();
          item = AuraHistory.findOne({
            _id: $(e.currentTarget).data('id')
          });
          selectorPath = item.collection + '::' + item.document + '::' + item.field;
          changedData = item.changedData;
          data = item.data;
          diff = Aura.diff.diff_prettyHtml(Aura.diff.diff_main(changedData, data));
          markup = Blaze.toHTMLWithData(Template.historyDiffCont, {
            selectorPath: selectorPath
          });
          $('body').append(markup);
          $('.aura-diff-cont').css('top', ($(e.currentTarget).offset().top - $(window).scrollTop()) + 'px').css('left', $(e.currentTarget).offset().left + 'px').addClass('_visible');
          return $('.aura-diff-cont').find('p').html($.htmlClean(diff, {
            format: true
          }));
        }, 1000);
      },
      'click #history-cont li': function(e) {
        var id, selectorPath;
        selectorPath = $(e.currentTarget).data('selector-path');
        id = $(e.currentTarget).data('id');
        return Meteor.call('restoreHistory', id, function(err, res) {
          if (err) {
            return console.log(err);
          } else {
            Aura.notify('История восстановлена!');
            if ($(selectorPath).length > 0) {
              Meteor.defer(function() {
                return $(selectorPath).html(res);
              });
            }
            return console.log('changed item saved');
          }
        });
      },
      'click #toggle-users': function() {
        return $('#auraUsersModal').addClass('_opened');
      },
      'click .aura-toggle-edit': function(e) {
        $(e.currentTarget).toggleClass('_active');
        if ($(e.currentTarget).hasClass('_active')) {
          Session.set('admin.editMode', true);
          return $(e.currentTarget).find('p').text('правка');
        } else {
          Session.set('admin.editMode', false);
          return $(e.currentTarget).find('p').text('просмотр');
        }
      },
      'click .aura-admin-button': function(e) {
        var target;
        if ($(e.currentTarget).attr('data-admin-toggle')) {
          if ($(e.currentTarget).hasClass('_expanded')) {
            $(e.currentTarget).removeClass('_expanded');
            target = $(e.currentTarget).data('admin-toggle');
            return $(target).removeClass('_expanded').height(0);
          } else {
            $(e.currentTarget).addClass('_expanded');
            target = $(e.currentTarget).data('admin-toggle');
            return $(target).addClass('_expanded').height($(target).find('>ul').height());
          }
        }
      }
    });
    Template.aura.rendered = function() {};
    Template.aura.events({
      'click .close span': function() {
        console.log('closing');
        return Aura.hideAdminModal();
      }
    });
    Template.auraLoginModal.events({
      'click .close': function() {
        return Aura.hideAdminModal();
      },
      'click #login': function(e) {
        var email, password;
        e.preventDefault();
        email = $('#login-email').val();
        password = $('#login-password').val();
        return Meteor.loginWithPassword(email, password, function() {
          return Aura.hideAdminModal();
        });
      }
    });
    Template.auraUsersModal.rendered = function() {
      return $('#aura-users-cont > ul > li').first().trigger('click');
    };
    Template.auraUsersModal.helpers({
      allUsers: function() {
        return Meteor.users.find();
      },
      getPermissions: function(roles) {
        var role;
        if (roles) {
          role = roles[0];
          if (role === 'admin') {
            return 'администратор';
          } else if (role === 'owner') {
            return 'владелец';
          }
        }
      },
      isNewUser: function() {
        if (Session.get('auraSelectedUser') === 'new') {
          return true;
        } else {
          return false;
        }
      },
      getImage: function(pic) {
        if (pic) {
          return "background-image: url(http://d1tvqt3gjtui5j.cloudfront.net/aura/" + pic + ")";
        } else {
          return '';
        }
      },
      selectedUser: function() {
        var id;
        id = Session.get('auraSelectedUser');
        return Meteor.users.findOne({
          '_id': id
        });
      }
    });
    Template.auraUsersModal.events({
      'click #aura-users-cont > ul > li': function(e) {
        var id;
        $(e.currentTarget).addClass('_active').siblings().removeClass('_active');
        if ($(e.currentTarget).hasClass('add-user')) {
          return Session.set('auraSelectedUser', 'new');
        } else {
          id = $(e.currentTarget).data('id');
          return Session.set('auraSelectedUser', id);
        }
      },
      'click .remove': function(e) {
        var id;
        id = $(e.currentTarget).closest('li').data('id');
        return Meteor.call('auraRemoveUser', id, function(err, res) {
          if (err) {
            return Aura.notify('Пользователь не удален, обратитесь к разработчику');
          } else {
            return Aura.notify('Пользователь удален!');
          }
        });
      }
    });
    Template.auraNewUser.events({
      'click #create-user': function() {
        var file, fr, options;
        if ($('#user-name').val() !== '' && $('#user-surname').val() !== '' && $('#user-email').val() !== '' && $('#user-password').val() !== '') {
          options = {
            name: $('#user-name').val(),
            surname: $('#user-surname').val(),
            email: $('#user-email').val(),
            password: $('#user-password').val(),
            role: $('#permissions-select').val(),
            pic: null
          };
          if (Meteor.users.findOne({
            'emails.$.address': options.email
          })) {
            return Aura.notify('Пользователь с таким e-mail уже существует!');
          } else {
            if ($('#user-pic').get(0).files[0]) {
              NProgress.start();
              file = $('#user-pic').get(0).files[0];
              fr = new FileReader();
              fr.onload = function() {
                var pic;
                pic = {};
                pic['data'] = fr.result;
                pic['name'] = file.name;
                pic['size'] = file.size;
                pic['type'] = file.type;
                return Meteor.call('uploadPic', pic, 'ahsl2/aura', function(error, newPic) {
                  NProgress.done();
                  if (error) {
                    return console.log(error);
                  } else {
                    options['pic'] = newPic;
                    return Meteor.call('auraCreateUser', options, function(err, res) {
                      if (err) {
                        return Aura.notify('Упс, что-то не так на сервере:( Обратитесь к разработчику', 'error');
                      } else {
                        Aura.notify('Ура, пользователь создан!', 'success');
                        return console.log(res);
                      }
                    });
                  }
                });
              };
              return fr.readAsBinaryString(file);
            } else {
              return Meteor.call('auraCreateUser', options, function(err, res) {
                if (err) {
                  return Aura.notify('Упс, что-то не так на сервере:( Обратитесь к разработчику', 'error');
                } else {
                  Aura.notify('Ура, пользователь создан!', 'success');
                  return console.log(res);
                }
              });
            }
          }
        } else {
          return Aura.notify('Пожалуйста, корректно заполните все поля формы, отмеченные звездочкой!');
        }
      }
    });
    Template.auraUsersModalSettings.rendered = function() {
      $('.aura-select').select2('destroy');
      return $('.aura-select').select2({
        minimumResultsForSearch: -1
      });
    };
    Template.auraNewUser.rendered = function() {
      $('.aura-select').select2('destroy');
      return $('.aura-select').select2({
        minimumResultsForSearch: -1
      });
    };
    Template.auraUsersModalSettings.helpers({
      getEmail: function(emails) {
        return emails[0].address;
      }
    });
    Template.auraEditor.rendered = function() {
      console.log('editor rendered');
      return $('.html-cont').on('keyup', function() {
        return Meteor.setTimeout(function() {
          var target, value;
          console.log('changing value');
          value = editor.auraEditorHtml.getValue().replace(/\s+/g, ' ');
          target = $('.editor').find('.html-cont').data('path');
          console.log(target);
          console.log(value);
          return $(target).html(value);
        }, 50);
      });
    };
    return Template.auraEditor.events({
      'click button': function(e) {
        var data;
        console.log(editor.editingItemSelector);
        if (editor.editingItemSelector) {
          data = editor.editingItemSelector.html();
          editor.editingItemSelector.trigger('input');
          return Meteor.setTimeout(function() {
            return editor.editingItem = data;
          }, 100);
        }
      },
      'click #b-html': function(e) {
        console.log('opening editor');
        if ($(e.target).hasClass('_active')) {
          $('.editor .html-cont').removeClass('flipInX').addClass('flipOutX');
          return $(e.currentTarget).removeClass('_active');
        } else {
          $('.editor .html-cont').css('visibility', 'visible').removeClass('flipOutX').addClass('animated flipInX');
          return $(e.currentTarget).addClass('_active');
        }
      },
      'blur .editor .html-cont textarea': function(e) {
        return $($(e.target).data('path')).trigger('blur');
      },
      'change #add-embed-image': function(e) {
        var file, fr, input;
        console.log('uploading embed image');
        input = $(e.target);
        file = input.get(0).files[0];
        fr = new FileReader();
        NProgress.start();
        fr.onload = function() {
          var pic;
          pic = {};
          pic['data'] = fr.result;
          pic['name'] = file.name;
          pic['size'] = file.size;
          pic['type'] = file.type;
          return Meteor.call('uploadPic', pic, 'ahsl2/images', function(error, newPic) {
            var html, path;
            NProgress.done();
            if (error) {
              return console.log(error);
            } else {
              path = 'http://d1tvqt3gjtui5j.cloudfront.net/images/' + newPic;
              html = document.createElement('img');
              html.setAttribute('src', path);
              html.setAttribute('data-aura-image-embed', '');
              html.setAttribute('class', 'aura-float-left');
              editor.commands.pasteHtml(html);
              return $(e.currentTarget).closest('[contenteditable]').trigger('input');
            }
          });
        };
        return fr.readAsBinaryString(file);
      },
      'click #b-bold': function() {
        return editor.commands.bold();
      },
      'click #b-add-quot': function() {
        var el;
        el = document.createElement('p');
        el.setAttribute('class', 'inline-quot');
        return editor.commands.wrapRange(el);
      },
      'click #b-add-video': function() {
        var code;
        code = prompt("Пожалуйста добавьте код видео с YouTube");
        return editor.commands.pasteHtml(code);
      },
      'click #b-italic': function() {
        return editor.commands.italic();
      },
      'click #b-sub': function() {
        return editor.commands.sub();
      },
      'click #b-sup': function() {
        return editor.commands.sup();
      },
      'click #b-ul': function() {
        return editor.commands.ul();
      },
      'click #b-ol': function() {
        return editor.commands.ol();
      },
      'click #b-h1': function() {
        return editor.commands.h1();
      },
      'click #b-h2': function() {
        return editor.commands.h2();
      },
      'click #b-h3': function() {
        return editor.commands.h3();
      },
      'click #b-h4': function() {
        return editor.commands.h4();
      },
      'click #b-h5': function() {
        return editor.commands.h5();
      },
      'click #b-h6': function() {
        return editor.commands.h6();
      },
      'click #b-span': function() {
        return editor.commands.span();
      },
      'click #b-link': function() {
        return editor.commands.link();
      },
      'click #b-align-left': function() {
        return editor.commands.justifyLeft();
      },
      'click #b-align-right': function() {
        return editor.commands.justifyRight();
      },
      'click #b-align-center': function() {
        return editor.commands.justifyCenter();
      },
      'click #b-align-justify': function() {
        return editor.commands.justifyFull();
      },
      'click #b-save': function(e) {
        editor.hideEditor();
        return editor.save();
      }
    });
  });
}

if (Meteor.isClient) {
  console.log('visible');
  Meteor.startup(function() {
    PNotify.prototype.options.styling = "fontawesome";
    $('body').on('dragover', '[data-aura-image-background], [data-aura-image], [data-aura-list-image-background], [data-aura-list-image], [data-aura-with-image-background], [data-aura-with-image]', function(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      $(e.currentTarget).addClass('_hover');
      return false;
    });
    $('body').on('dragenter', '[data-aura-image-background], [data-aura-image], [data-aura-list-image-background], [data-aura-list-image], [data-aura-with-image-background], [data-aura-with-image]', function(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      $(e.currentTarget).addClass('_hover');
      return false;
    });
    $('body').on('dragleave', '[data-aura-image-background], [data-aura-image], [data-aura-list-image-background], [data-aura-list-image], [data-aura-with-image-background], [data-aura-with-image]', function(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      $(e.currentTarget).removeClass('_hover');
      return false;
    });
    $('body').on('drop', '[data-aura-image-background], [data-aura-image], [data-aura-list-image-background], [data-aura-list-image], [data-aura-with-image-background], [data-aura-with-image]', function(e) {
      var file, fr;
      if (Session.get('admin.editMode')) {
        console.log('droped');
        e.preventDefault();
        e.stopPropagation();
        $(e.target).removeClass('_hover');
        NProgress.start();
        file = e.originalEvent.dataTransfer.files[0];
        fr = new FileReader();
        fr.onload = function() {
          var currentPic, pic;
          pic = {};
          pic['data'] = fr.result;
          pic['name'] = file.name;
          pic['size'] = file.size;
          pic['type'] = file.type;
          currentPic = (function() {
            var path;
            if ($(e.currentTarget).data('aura-image-background') || $(e.currentTarget).data('aura-list-image-background') || $(e.currentTarget).data('aura-with-image-background')) {
              path = $(e.currentTarget).css('background-image');
              return _.last(path.split('/')).replace(')', '');
            } else {
              path = $(e.currentTarget).attr('src');
              return _.last(path.split('/'));
            }
          })();
          return (new PNotify({
            title: 'Удалить старое изображение?',
            text: 'Желательно удалять, чтобы не перегружать хостинг',
            hide: false,
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
            Aura.media.updatePic(e, pic, file, currentPic, 'ahsl2/images', false);
            console.log(pic);
            console.log(file);
            return console.log(currentPic);
          }).on('pnotify.cancel', function() {
            Aura.media.uploadPic(e, pic, file, 'ahsl2/images', false);
            console.log(pic);
            console.log(file);
            return console.log(currentPic);
          });
        };
        return fr.readAsBinaryString(file);
      }
    });
    $('body').on('paste', '[data-aura-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"]', function(e) {
      var $el;
      console.log('pasted');
      $el = $(e.target).closest('[contenteditable="true"]');
      return Meteor.defer(function() {
        var cleanHtml, html;
        html = $el.html();
        cleanHtml = AuraUtils.cleanHTML(html);
        console.log(cleanHtml);
        return $el.html(cleanHtml);
      }, 100);
    });
    $('body').on('dragover', '[data-aura-image-embed]', function(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      $(e.currentTarget).addClass('_hover');
      return false;
    });
    $('body').on('dragenter', '[data-aura-image-embed]', function(e) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      $(e.currentTarget).addClass('_hover');
      return false;
    });
    $('body').on('dragleave', '[data-aura-image-embed]', function(e) {
      $(e.currentTarget).removeClass('_hover');
      return false;
    });
    $('body').on('drop', '[data-aura-image-embed]', function(e) {
      var file, fr, path;
      if (Session.get('admin.editMode')) {
        console.log('droped');
        NProgress.start();
        e.preventDefault();
        e.stopPropagation();
        $(e.currentTarget).removeClass('_hover');
        file = e.originalEvent.dataTransfer.files[0];
        fr = new FileReader();
        path = $(e.currentTarget).attr('src');
        fr.onload = function() {
          var currentPic, pic;
          pic = {};
          pic['data'] = fr.result;
          pic['name'] = file.name;
          pic['size'] = file.size;
          pic['type'] = file.type;
          currentPic = (function() {
            return _.last(path.split('/'));
          })();
          return Meteor.call('deletePic', currentPic, 'ahsl2/images', function(err, res) {
            if (err) {
              return console.log(err);
            } else {
              return Meteor.call('uploadPic', pic, 'ahsl2/images', function(error, newPic) {
                NProgress.done();
                if (error) {
                  return console.log(error);
                } else {
                  $(e.currentTarget).attr('src', _.without(path.split('/'), _.last(path.split('/'))).join('/') + '/' + newPic);
                  return $(e.currentTarget).closest('[contenteditable]').trigger('input');
                }
              });
            }
          });
        };
        return fr.readAsBinaryString(file);
      }
    });
    $('body').on('focus', '[data-aura-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"],  [data-aura-with-html][contenteditable="true"]', 'focus', function(e) {
      var data, markup;
      console.log('focused on element');
      e.stopImmediatePropagation();
      e.stopPropagation();
      data = $(e.currentTarget).html();
      markup = $.htmlClean(data, {
        format: true
      });
      editor.showEditor(markup);
      editor._trackChanges.currentValue = data;
      editor.editingItem = data;
      editor.editingItemSelector = $(e.currentTarget);
      $('.editor .html-cont').data('resetData', markup);
      return $('.editor .html-cont').data('path', $(e.target).closest('[contenteditable="true"]').getPath());
    });
    $('body').on('blur', '[data-aura-html][contenteditable="true"], [data-aura-list-html][contenteditable="true"],  [data-aura-with-html][contenteditable="true"]', function(e) {
      var coll, currentState, docIndex, document, field, index, list, query, withQuery, withRule;
      console.log('blurred');
      if (!editor.blured) {
        console.log('editor not blured');
        currentState = $(e.currentTarget).html();
        if (currentState !== editor.editingItem) {
          console.log('currentState isnt editor.editingItem');
          $('.editor .html-cont textarea').data('index', editor._changedBuffer.length);
          if ($(e.currentTarget).data('aura-html')) {
            query = $(e.currentTarget).data('aura-html');
            document = query.split('.')[0];
            field = query.split('.').splice(1).join();
          } else if ($(e.currentTarget).data('aura-list-html')) {
            query = $(e.currentTarget).data('aura-list-html');
            list = $(e.currentTarget).closest('[data-aura-list]').data('aura-list');
            index = $(e.currentTarget).closest('[data-aura-list-item]').index();
            document = list.split('.')[0];
            field = list.split('.')[1] + '.' + index + '.' + query;
            console.log(document);
            console.log(field);
            console.log(index);
          } else if ($(e.currentTarget).data('aura-with-html')) {
            query = $(e.currentTarget).data('aura-with-html');
            withRule = $(e.currentTarget).closest('[data-aura-with]').data('aura-with');
            withQuery = (function() {
              if (withRule.split('.')) {
                return withRule.split('.')[0];
              } else {
                return withRule;
              }
            })();
            document = withQuery;
            field = query;
            console.log('this is with');
          }
          coll = (function() {
            if ($(e.currentTarget).closest('[data-aura-collection]').length > 0) {
              return $(e.currentTarget).closest('[data-aura-collection]').data('aura-collection');
            } else {
              return 'auraPages';
            }
          })();
          docIndex = (function() {
            if ($(e.currentTarget).closest('[data-aura-index]').length > 0) {
              return $(e.currentTarget).closest('[data-aura-index]').data('aura-index');
            } else {
              return 'name';
            }
          })();
          console.log('indx');
          console.log(docIndex);
          console.log(coll);
          editor._changedBuffer.push({
            field: field,
            document: document,
            index: docIndex,
            collection: coll,
            data: $.htmlClean(currentState, {
              format: true
            }),
            changedData: $.htmlClean(editor.editingItem, {
              format: true
            }),
            selectorPath: $(e.currentTarget).getPath(),
            type: 'html'
          });
          console.log(editor._changedBuffer);
          $(e.target).closest('[contenteditable="true"]').addClass('_changed');
          editor.blured = true;
          return Meteor.setTimeout(function() {
            return editor.blured = false;
          }, 1000);
        }
      }
    });
    $('body').on('input', '[data-aura-html][contenteditable=true], [data-aura-with-html][contenteditable=true], [data-aura-list-html][contenteditable=true]', function(e) {
      var markup;
      return markup = $(e.currentTarget).html();
    });
    $('body').on('click', '[data-aura-list-remove]', function(e) {
      var document, field, index, list, object;
      index = $(e.currentTarget).closest('[data-aura-list-item]').index();
      list = $(e.currentTarget).closest('[data-aura-list]').data('aura-list');
      document = list.split('.')[0];
      field = list.split('.')[1];
      object = AuraPages.findOne({
        name: document
      }).classes[index];
      return Meteor.call('removeListItem', document, field, object, function(err, res) {
        if (err) {
          return console.log(err);
        }
      });
    });
    $('body').on('click', '[data-aura-list-add]', function(e) {
      var document, field, list, sample;
      list = $(e.currentTarget).closest('[data-aura-list]').data('aura-list');
      document = list.split('.')[0];
      field = list.split('.')[1];
      sample = AuraPages.findOne({
        name: document
      })[field][0];
      return Meteor.call('addListItem', document, field, sample, function(err, res) {
        if (err) {
          return console.log(err);
        }
      });
    });
    $('body').on('mouseenter', '[data-aura-image-background]', function(e) {
      return $(e.currentTaget).addClass('_hover');
    });
    $('body').on('mouseleave', '[data-aura-image-background]', function(e) {
      return $(e.currentTaget).removeClass('_hover');
    });
    $('body').on('click', '[data-aura-image-embed]', function(e) {
      var id, left, top;
      if (Session.get('admin.editMode')) {
        id = (function() {
          if ($(e.currentTarget).hasClass('aura-float-left')) {
            return 'set-float-left';
          } else if ($(e.currentTarget).hasClass('aura-float-right')) {
            return 'set-float-right';
          } else {
            return 'set-centered';
          }
        })();
        $(e.currentTarget).addClass('aura-image-highlight');
        top = $(e.currentTarget).offset().top - 60;
        left = $(e.currentTarget).offset().left;
        if ($('.aura-image-embed-overlay').length === 0) {
          $('body').append('<div class="aura-image-embed-overlay"></div>');
          $('body').append(editor.imageEmbedEdit);
          $('.image-embed-edit').css('left', left + 'px').css('top', top + 'px');
          Meteor.setTimeout(function() {
            return $('.image-embed-edit').addClass('_opened');
          }, 100);
          return $('.image-embed-edit').find('#' + id).addClass('_active');
        }
      }
    });
    $('body').on('click', '.image-embed-edit button', function(e) {
      var $img, left, pic, target, top;
      $img = $('.aura-image-highlight');
      if (!$(e.currentTarget).hasClass('remove')) {
        $(e.currentTarget).addClass('_active').siblings().removeClass('_active');
        target = $(e.currentTarget).data('class');
        $img.removeClass('aura-float-left').removeClass('aura-float-right').removeClass('aura-centered');
        $img.addClass(target);
        top = $img.offset().top - 60;
        left = $img.offset().left;
        Meteor.setTimeout(function() {
          return $('.image-embed-edit').css('left', left + 'px').css('top', top + 'px');
        }, 400);
        return $(editor.editingItemSelector).trigger('blur');
      } else {
        pic = _.last($img.attr('src').split('/'));
        return Meteor.call('deletePic', pic, 'ahsl2/images', function(err, res) {
          if (err) {
            return console.log(err);
          } else {
            $img.remove();
            $('.image-embed-edit').remove();
            $('.aura-image-embed-overlay').remove();
            $(e.currentTarget).closest('[contenteditable]').trigger('input');
            return Aura.notify('Изображение удалено!');
          }
        });
      }
    });
    $('body').on('click', '.aura-image-embed-overlay', function(e) {
      $('[data-aura-image-embed]').removeClass('aura-image-highlight');
      $('.image-embed-edit').removeClass('_opened');
      Meteor.setTimeout(function() {
        return $('.image-embed-edit').remove();
      }, 400);
      return $(e.currentTarget).remove();
    });
    $('body').on('change', '[data-aura-instant-checkbox]', function(e) {
      var item, query, value;
      query = $(e.currentTarget).data('aura-instant-checkbox').split('.');
      value = $(e.currentTarget).val();
      item = {};
      item['collection'] = query[0];
      item['document'] = query[1];
      item['index'] = '_id';
      query.shift();
      query.shift();
      item['field'] = query;
      item['data'] = $(e.currentTarget).is(':checked');
      return Meteor.call('saveHtml', item, function(err, res) {
        if (err) {
          return console.log(err);
        } else {
          return Aura.notify('Изменения сохранены!');
        }
      });
    });
    $('body').on('change', '[data-aura-instant-select]', function(e) {
      var item, query, value;
      if ($(e.currentTarget).val() !== '-') {
        query = $(e.currentTarget).data('aura-instant-select').split('.');
        value = $(e.currentTarget).val();
        item = {};
        item['collection'] = query[0];
        item['document'] = query[1];
        item['index'] = '_id';
        query.shift();
        query.shift();
        item['field'] = query;
        item['data'] = value;
        return Meteor.call('saveHtml', item, function(err, res) {
          if (err) {
            return console.log(err);
          } else {
            return Aura.notify('Изменения сохранены!');
          }
        });
      }
    });
    return $('body').on('input', '[data-aura-instant-input]', function(e) {
      if (Aura.inputInstantTimeout) {
        clearTimeout(Aura.inputInstantTimeout);
      }
      return Aura.inputInstantTimeout = Meteor.setTimeout((function(_this) {
        return function() {
          var item, query, value;
          query = $(e.currentTarget).data('aura-instant-input').split('.');
          value = $(e.currentTarget).val();
          item = {};
          item['collection'] = query[0];
          item['document'] = query[1];
          item['index'] = '_id';
          query.shift();
          query.shift();
          item['field'] = query;
          item['data'] = (function() {
            if ($(e.currentTarget).attr('type') === 'date') {
              return Date.parse(new Date(value));
            } else {
              return value;
            }
          })();
          console.log(item);
          return Meteor.call('saveHtml', item, function(err, res) {
            if (err) {
              return console.log(err);
            } else {
              Aura.notify('Изменения сохранены!');
              if ($(e.currentTarget).attr('id') === 'aura-alias-input') {
                return Router.go(Router.current().route.getName(), {
                  alias: value
                });
              }
            }
          });
        };
      })(this), 1500);
    });
  });
}

this.Aura = {
  showAdminModal: function() {
    return $('#admin-login-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY');
  },
  hideAdminModal: function() {
    $('#admin-login-modal').removeClass('flipInY').addClass('flipOutY');
    return setTimeout(function() {
      return $('#admin-login-modal').css('visibility', 'hidden');
    }, 500);
  },
  toggleEditMode: function() {
    if (Session.get('admin.editMode')) {
      Session.set('admin.editMode', false);
      return Aura.notify('Режим просмотра');
    } else {
      Session.set('admin.editMode', true);
      return Aura.notify('Режим правки');
    }
  },
  notify: function(message) {
    return new PNotify({
      title: 'Спасибо!',
      text: message,
      addclass: 'aura-notify'
    });
  },
  inputInstantTimeout: null,
  media: {
    uploadPic: function(e, pic, file, callback) {
      NProgress.start();
      return Meteor.call('uploadPic', pic, 'ahsl2/images', function(err, res) {
        var index, item, list, query, withQuery, withRule;
        NProgress.done();
        if (err) {
          return Aura.notify('Произошла ошибка, обратитесь к разработчику!');
        } else {
          if ($(e.currentTarget).data('aura-image-background') || $(e.currentTarget).data('aura-image')) {
            query = (function() {
              return $(e.currentTarget).data('aura-image-background') || $(e.currentTarget).data('aura-image');
            })();
            item = {};
            item['document'] = query.split('.')[0];
            item['field'] = query.split('.').splice(1).join();
            item['data'] = res;
          } else if ($(e.currentTarget).data('aura-list-image-background') || $(e.currentTarget).data('aura-list-image')) {
            query = $(e.currentTarget).data('aura-list-image-background') || $(e.currentTarget).data('aura-list-image');
            list = $(e.currentTarget).closest('[data-aura-list]').data('aura-list');
            index = $(e.currentTarget).closest('[data-aura-list-item]').index();
            item = {};
            item['document'] = list.split('.')[0];
            item['field'] = list.split('.')[1] + '.' + index + '.' + query;
            item['data'] = res;
          } else if ($(e.currentTarget).data('aura-with-image-background') || $(e.currentTarget).data('aura-with-image')) {
            query = $(e.currentTarget).data('aura-with-image-background') || $(e.currentTarget).data('aura-with-image');
            withRule = $(e.currentTarget).closest('[data-aura-with]').data('aura-with');
            withQuery = (function() {
              if (withRule.split('.')) {
                return withRule.split('.')[0];
              } else {
                return withRule;
              }
            })();
            item = {};
            item['document'] = withQuery;
            item['field'] = query;
            item['data'] = res;
          }
          item['collection'] = (function() {
            if ($(e.currentTarget).closest('[data-aura-collection]').length > 0) {
              return $(e.currentTarget).closest('[data-aura-collection]').data('aura-collection');
            } else {
              return 'auraPages';
            }
          })();
          item['index'] = (function() {
            if ($(e.currentTarget).closest('[data-aura-index]').length > 0) {
              return $(e.currentTarget).closest('[data-aura-index]').data('aura-index');
            } else {
              return 'name';
            }
          })();
          Meteor.call('saveHtml', item, function(error, response) {
            if (err) {
              return console.log('Smth went wrong');
            }
          });
          return console.log(item);
        }
      });
    },
    updatePic: function(e, pic, file, currentPic) {
      return Meteor.call('deletePic', currentPic, 'ahsl2/images', function(err, res) {
        if (err) {
          return Aura.notify('Изображение не удалено:( Может и к лучшему))');
        } else {
          if (res) {
            return Aura.media.uploadPic(e, pic, file);
          } else {
            return Aura.notify('Изображение не удалено:( Ошибка на стороне сервера');
          }
        }
      });
    },
    resizeAndUpload: function(id, file, callback) {
      var fileInfo, originalFile, resize;
      console.log('triggered upload with resize');
      fileInfo = file;
      resize = function() {
        var deferred;
        console.log('procesing resize ');
        deferred = $.Deferred();
        $.canvasResize(file, {
          width: 150,
          height: 0,
          crop: false,
          quality: 80,
          callback: function(data) {
            deferred.resolve(data);
            console.log('resized img');
            return console.log({
              data: data
            });
          }
        });
        return deferred.promise();
      };
      originalFile = function() {
        var deferred2, reader;
        deferred2 = $.Deferred();
        console.log('processing original file');
        reader = new FileReader();
        reader.readAsBinaryString(file);
        reader.onload = function(e) {
          var ifile;
          ifile = reader.result;
          deferred2.resolve(ifile);
          return console.log({
            reader: ifile
          });
        };
        return deferred2.promise();
      };
      return $.when(originalFile(), resize()).done((function(_this) {
        return function(ifile, resizedFile) {
          var pic, resizedPic;
          pic = {};
          resizedPic = {};
          pic['fileInfo'] = {};
          resizedPic['fileInfo'] = {};
          console.log('resolved');
          pic['fileInfo']['name'] = fileInfo.name;
          pic['fileInfo']['type'] = fileInfo.type;
          pic['fileInfo']['size'] = fileInfo.size;
          pic['data'] = ifile;
          resizedPic['fileInfo']['name'] = fileInfo.name;
          resizedPic['fileInfo']['type'] = fileInfo.type;
          resizedPic['fileInfo']['size'] = fileInfo.size;
          resizedPic['data'] = resizedFile;
          return Meteor.call('uploadWithThumb', [pic, resizedPic], 'ahsl2/gallery', function(err, res) {
            if (err) {
              return Aura.notify('Упс, что-то пошло не так:(');
            } else {
              if (res) {
                return callback(res);
              } else {
                return Aura.notify('Что-то пошло не так, обратитесь к разработчику!');
              }
            }
          });
        };
      })(this));
    },
    deletePic: function(pic) {
      return Meteor.call('deletePic', pic, 'ahsl2/images', function(err, res) {
        if (err) {
          return Aura.notify('Изображение не удалено:( Может и к лучшему))');
        } else {
          if (res) {
            return Aura.notify('Изображение успешно удалено!');
          } else {
            return Aura.notify('Изображение не удалено:( Ошибка на стороне сервера');
          }
        }
      });
    },
    deletePics: function(pics) {
      return Meteor.call('deletePics', pics, function(err, res) {
        if (err) {
          return Aura.notify('Изображения не удалены:( Может и к лучшему))');
        } else {
          if (res) {
            return Aura.notify('Изображения успешно удалено!');
          } else {
            return Aura.notify('Изображения не удалены:( Ошибка на стороне сервера');
          }
        }
      });
    }
  },
  _logsWrite: function(buffer) {
    return _.each(buffer, function(log) {
      return Logs.insert({
        field: log.field,
        collection: log.collection,
        date: new Date(),
        user: 'Albert Kai'
      });
    });
  },
  _historyBuffer: [],
  _saveHistory: function(buffer) {
    var historyCount, toDelete, toDeleteSize;
    console.log('triggered saveHistory');
    historyCount = History.find().count();
    if (historyCount + buffer.length > Aura.settings.history.size) {
      toDeleteSize = historyCount + buffer.length - Aura.settings.history.size;
      toDelete = History.find({}, {
        sort: {
          date: 1
        },
        limit: toDeleteSize
      }).fetch();
      toDelete.forEach(function(item) {
        var id;
        id = item._id;
        return History.remove(id);
      });
    }
    return _.each(buffer, function(history) {
      var target;
      if (!history.rolledBack) {
        History.insert({
          field: history.field,
          collection: history.collection,
          document: history.document,
          indexField: history.indexField,
          date: new Date(),
          data: history.data,
          selectorPath: history.selectorPath,
          newData: history.newData,
          type: history.type,
          user: Meteor.user(),
          rolledBack: history.rolledBack,
          changable: history.changeable
        });
        return console.log('triggered saveHistory iterate');
      } else {
        target = History.findOne({
          _id: history._id
        });
        target.rolledBack = !buffer.rolledBack;
        return History.update({
          _id: history._id
        }, history);
      }
    });
  },
  users: {
    addUser: function(options) {
      return Meteor.call('auraAddUser', function(options) {});
    }
  }
};

this.editor = {
  blured: false,
  editingItem: '',
  _changedBuffer: [],
  editingItemSelector: null,
  auraEditorHtml: null,
  htmlEditorInit: function() {
    return editor.auraEditorHtml = ace.edit("editorHtml");
  },
  commands: {
    bold: function() {
      return document.execCommand('bold', null, null);
    },
    italic: function() {
      return document.execCommand('italic', null, null);
    },
    sub: function() {
      return document.execCommand('subscript', null, null);
    },
    sup: function() {
      return document.execCommand('superscript', null, null);
    },
    ul: function() {
      return document.execCommand('insertUnorderedList', null, null);
    },
    ol: function() {
      return document.execCommand('insertOrderedList', null, null);
    },
    h1: function() {
      return document.execCommand('formatBlock', null, '<h1>');
    },
    h2: function() {
      return document.execCommand('formatBlock', null, '<h2>');
    },
    h3: function() {
      return document.execCommand('formatBlock', null, '<h3>');
    },
    h4: function() {
      return document.execCommand('formatBlock', null, '<h4>');
    },
    h5: function() {
      return document.execCommand('formatBlock', null, '<h5>');
    },
    h6: function() {
      return document.execCommand('formatBlock', null, '<h6>');
    },
    span: function() {
      return document.execCommand('formatBlock', null, '<span>');
    },
    link: function() {
      return document.execCommand('createLink', false, prompt('Введите URL'));
    },
    justifyLeft: function() {
      return document.execCommand('justifyLeft', null, null);
    },
    justifyCenter: function() {
      return document.execCommand('justifyCenter', null, null);
    },
    justifyRight: function() {
      return document.execCommand('justifyRight', null, null);
    },
    justifyFull: function() {
      return document.execCommand('justifyFull', null, null);
    },
    pasteHtml: function(html) {
      var range;
      range = window.getSelection().getRangeAt(0);
      return range.insertNode(html);
    },
    wrapRange: function(node) {
      var range, sel;
      sel = window.getSelection();
      if (sel.rangeCount) {
        range = sel.getRangeAt(0).cloneRange();
        range.surroundContents(node);
        sel.removeAllRanges();
        return sel.addRange(range);
      }
    }
  },
  save: function() {
    var changedBuffer, counter, length;
    console.log('saving content');
    if (this._changedBuffer.length > 0) {
      changedBuffer = editor._changedBuffer;
      length = changedBuffer.length;
      counter = 0;
      return changedBuffer.forEach(function(buffer) {
        Meteor.call('saveHtml', buffer, function(err, res) {
          if (err) {
            return console.log(err);
          } else {
            console.log(buffer);
            console.log(buffer.selectorPath);
            Meteor.defer(function() {
              $(buffer.selectorPath).html(buffer.data);
              return console.log('refreshed');
            });
            return console.log('changed item saved');
          }
        });
        counter++;
        if (counter === length) {
          editor._changedBuffer = [];
          return Aura.notify('Изменения сохранены!');
        }
      });
    }
  },
  imageEmbedEdit: '<div class="image-embed-edit"><button id="set-float-left" data-class="aura-float-left"><i class="fa fa-long-arrow-left"></i></button><button id="set-centered" data-class="aura-centered"><i class="fa fa-arrows-h"></i></button><button id="set-float-right" data-class="aura-float-right"><i class="fa fa-long-arrow-right"></i></button><button class="remove"><i class="fa fa-times"></i></button></div>',
  _trackChanges: {
    currentValue: '',
    check: function($el) {
      console.log(this.currentValue);
      if ($el.html() !== this.currentValue) {
        return true;
      } else {
        return false;
      }
    }
  },
  editorSaveText: function(changedBuffer, callback) {
    var user;
    console.log(changedBuffer);
    user = Meteor.user();
    if (Roles.userIsInRole(user, ['admin'])) {
      console.log('triggered saveText');
      return _.each(changedBuffer, function(change) {
        var newData, pageId, query, updateObj;
        if (!change.nested) {
          console.log('triggered saveText iterate');
          newData = {};
          query = {};
          query[change.indexField] = change.document;
          pageId = eColl[change.collection].findOne(query)._id;
          newData[change.field] = change.data;
          eColl[change.collection].update(pageId, {
            $set: newData
          }, function() {
            console.log('saved');
            return console.log(change.data);
          });
          return callback();
        } else if (change.nested.type === 'array') {
          console.log('triggered saveText iterate array');
          newData = {};
          query = {};
          query[change.indexField] = change.document;
          updateObj = {};
          updateObj['_id'] = eColl[change.collection].findOne(query)._id;
          console.log(eColl[change.collection].findOne({
            'name': change.document
          })._id);
          updateObj[change.nested.field + '.id'] = change.nested.id;
          newData[change.nested.field + '.$.' + change.field] = change.data;
          eColl[change.collection].update(updateObj, {
            $set: newData
          }, function() {
            return console.log('saved');
          });
          return callback();
        }
      });
    } else {
      return Meteor.Error(403, 'Not allowed');
    }
  },
  showEditor: function(val) {
    $('.editor').addClass('_opened');
    return $('.editor').find('button').removeClass('_active');
  },
  hideEditor: function() {
    $('.editor').removeClass('_opened');
    return $('.editor').find('.html-cont').removeClass('flipInX').addClass('flipOutX');
  }
};

Aura.settings = {
  history: {
    size: 30
  }
};
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                    //
// packages/aura:core/lib/credentials.coffee.js                                                                       //
//                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                      //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Meteor.startup(function() {
  process.env.MAIL_URL = 'smtp://albertkai:56114144as@smtp.sendgrid.net:587';
  process.env.AWS_KEY_ID = 'AKIAJKHELBJSF7V6D7FQ';
  return process.env.AWS_SECRET = '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';
});
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                    //
// packages/aura:core/server/server.coffee.js                                                                         //
//                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                      //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
console.log('Aura server initialized');

Meteor.publish('auraPages', function() {
  return AuraPages.find();
});

Meteor.publish('users', function() {
  return Meteor.users.find();
});

Meteor.publish('auraHistory', function() {
  return AuraHistory.find();
});

Meteor.publish('auraLogs', function() {
  return AuraLogs.find();
});

Meteor.publish('auraSettings', function() {
  return AuraSettings.find();
});

if (Meteor.isServer) {
  Meteor.startup(function() {
    this.Future = Npm.require('fibers/future');
    this.fs = Npm.require('fs');
    this.AWS = Npm.require('aws-sdk');
    this.dataUriToBuffer = Npm.require('data-uri-to-buffer');
    AWS.config.update({
      accessKeyId: process.env.AWS_KEY_ID,
      secretAccessKey: process.env.AWS_SECRET
    });
    return AWS.config.region = 'eu-west-1';
  });
}

if (Meteor.isServer) {
  Meteor.methods({
    uploadPic: function(pic, bucket) {
      var buffer, f, loggedInUser, newName, origImage, s3;
      loggedInUser = Meteor.user();
      if (Roles.userIsInRole(loggedInUser, ['owner', 'admin'])) {
        s3 = new AWS.S3();
        buffer = new Buffer(pic.data, 'binary');
        newName = (function() {
          var extention, randomName;
          extention = _.last(pic.name.split('.'));
          randomName = Random.id();
          return randomName + '.' + extention;
        })();
        origImage = {
          Key: newName,
          ContentType: pic.type,
          Body: buffer,
          Bucket: bucket
        };
        f = new Future();
        s3.putObject(origImage, function(err, data) {
          if (err) {
            console.log(err);
            return f["return"](false);
          } else {
            console.log('object ' + pic.name + ' with new name ' + newName + ' uploaded to S3! Congrats!');
            return f["return"](newName);
          }
        });
        return f.wait();
      }
    },
    uploadWithThumb: function(pics, bucket) {
      var f, loggedInUser, newName, origBuffer, origImage, resizedBuffer, resizedImage, s3;
      loggedInUser = Meteor.user();
      if (Roles.userIsInRole(loggedInUser, ['owner', 'admin'])) {
        s3 = new AWS.S3();
        origBuffer = new Buffer(pics[0].data, 'binary');
        resizedBuffer = dataUriToBuffer(pics[1].data);
        console.log(pics);
        console.log(pics[0].fileInfo);
        console.log(pics[0].fileInfo.name);
        newName = (function() {
          var extention, randomName;
          extention = _.last(pics[0].fileInfo.name.split('.'));
          randomName = Random.id();
          return {
            orig: randomName + '.' + extention,
            thumb: randomName + '_thumb.' + extention
          };
        })();
        origImage = {
          Key: newName.orig,
          ContentType: pics[0].fileInfo.type,
          Body: origBuffer,
          Bucket: bucket
        };
        resizedImage = {
          Key: newName.thumb,
          ContentType: pics[0].fileInfo.type,
          Body: resizedBuffer,
          Bucket: bucket
        };
        f = new Future();
        s3.putObject(origImage, function(err, data) {
          if (err) {
            console.log(err);
            return f["return"](false);
          } else {
            console.log('object ' + pics[0].fileInfo.name + ' named ' + newName.orig + ' uploaded to S3! Congrats!');
            return f["return"](true);
          }
        });
        f.wait();
        f = new Future();
        s3.putObject(resizedImage, function(err, data) {
          if (err) {
            console.log(err);
            return f["return"](false);
          } else {
            console.log('object ' + pics[1].fileInfo.name + ' thumb named ' + newName.thumb + ' uploaded to S3');
            return f["return"](true);
          }
        });
        f.wait();
        return newName.orig;
      }
    },
    deletePic: function(pic, bucket) {
      var f, loggedInUser, params, s3;
      loggedInUser = Meteor.user();
      if (Roles.userIsInRole(loggedInUser, ['owner', 'admin'])) {
        s3 = new AWS.S3();
        params = {
          Bucket: bucket,
          Key: pic
        };
        f = new Future();
        s3.deleteObject(params, function(err, data) {
          if (err) {
            console.log(err, err.stack);
            return f["return"](false);
          } else {
            console.log(data);
            console.log('object ' + pic + ' deleted from S3');
            return f["return"](true);
          }
        });
        return f.wait();
      }
    },
    deletePics: function(pics, bucket) {
      var f, loggedInUser, params, s3;
      loggedInUser = Meteor.user();
      if (Roles.userIsInRole(loggedInUser, ['owner', 'admin'])) {
        if (pics.length > 0) {
          s3 = new AWS.S3();
          params = {
            Bucket: bucket,
            Delete: {
              Objects: []
            }
          };
          pics.forEach(function(pic) {
            var obj;
            obj = {};
            obj['Key'] = pic;
            return params.Delete.Objects.push(obj);
          });
          f = new Future();
          s3.deleteObjects(params, function(err, data) {
            if (err) {
              console.log(err, err.stack);
              return f["return"](false);
            } else {
              console.log('object ' + pics + ' deleted from S3');
              return f["return"](true);
            }
          });
          return f.wait();
        } else {
          console.log('no pics to delete');
          return true;
        }
      }
    },
    auraCreateUser: function(options) {
      var loggedInUser, user;
      console.log('creating new user');
      loggedInUser = Meteor.user();
      if (Roles.userIsInRole(loggedInUser, ['owner'])) {
        user = Accounts.createUser({
          username: options.name,
          email: options.email,
          password: options.password,
          profile: {
            name: options.name,
            surname: options.surname,
            pic: options.pic != null ? options.pic : void 0
          }
        });
        Roles.addUsersToRoles(user, options.role);
        return user;
      } else {
        return 'Permission denied';
      }
    },
    auraRemoveUser: function(id) {
      var loggedInUser, userToDelete;
      loggedInUser = Meteor.user();
      userToDelete = Meteor.users.findOne({
        _id: id
      });
      if (Roles.userIsInRole(loggedInUser, ['owner'])) {
        if (!Roles.userIsInRole(userToDelete, ['owner'])) {
          return Meteor.users.remove({
            '_id': id
          });
        } else {
          return Aura.notify('Нельзя удалить владельца сайта, обратитесь для этого к разработчику');
        }
      }
    },
    saveHtml: function(item) {
      var loggedInUser, query, searchQuery;
      loggedInUser = Meteor.user();
      if (Roles.userIsInRole(loggedInUser, ['owner', 'admin'])) {
        query = {};
        searchQuery = {};
        query[item.field] = item.data;
        searchQuery[item.index] = item.document;
        console.log(item);
        console.log(searchQuery);
        console.log(query);
        AuraColl[item.collection].update(searchQuery, {
          $set: query
        });
        return Meteor.call('saveHistory', item);
      }
    },
    saveHistory: function(item) {
      var historyItem, loggedInUser;
      loggedInUser = Meteor.user();
      console.log('History item:');
      historyItem = item;
      if (Roles.userIsInRole(loggedInUser, ['owner', 'admin'])) {
        historyItem['userId'] = loggedInUser._id;
        historyItem['name'] = loggedInUser.profile.name;
        historyItem['surname'] = loggedInUser.profile.surname;
        historyItem['date'] = Date.parse(new Date());
        historyItem['restored'] = false;
        console.log(historyItem);
        return AuraHistory.insert(historyItem);
      }
    },
    restoreHistory: function(id) {
      var item, loggedInUser, query, searchQuery;
      loggedInUser = Meteor.user();
      item = AuraHistory.findOne({
        _id: id
      });
      console.log('Restoring history item:');
      console.log(item);
      if (Roles.userIsInRole(loggedInUser, ['owner', 'admin'])) {
        query = {};
        searchQuery = {};
        searchQuery[item.index] = item.document;
        query[item.field] = (function() {
          if (!item.restored) {
            return item.changedData;
          } else {
            return item.data;
          }
        })();
        AuraColl[item.collection].update(searchQuery, {
          $set: query
        });
        AuraHistory.update({
          _id: id
        }, {
          $set: {
            restored: !item.restored
          }
        });
        return query[item.field];
      }
    },
    addListItem: function(document, field, object) {
      var loggedInUser, query;
      loggedInUser = Meteor.user();
      if (Roles.userIsInRole(loggedInUser, ['owner', 'admin'])) {
        query = {};
        query[field] = object;
        return AuraPages.update({
          'name': document
        }, {
          $push: query
        });
      }
    },
    removeListItem: function(document, field, object) {
      var loggedInUser, query;
      loggedInUser = Meteor.user();
      if (Roles.userIsInRole(loggedInUser, ['owner', 'admin'])) {
        query = {};
        query[field] = object;
        return AuraPages.update({
          'name': document
        }, {
          $pull: query
        });
      }
    }
  });
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                    //
// packages/aura:core/server/seed.coffee.js                                                                           //
//                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                      //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
if (AuraPages.find({
  name: 'summer'
}).count() === 0) {
  AuraPages.insert({
    name: 'summer',
    mainDesc: '<h2>Австрийская Высшая Школа Леди предлагает Вам ознакомиться с летним проектом 2015.</h2> <p>Являясь одним из важнейших образовательных центров России, школа специализирующаяся на профессиональном образовании в сфере творческих и гуманитарных дисциплин по передовым международным образовательным программам в области искусства, дизайна, этикета и другим направлениям. Австрийская Высшая Школа Леди представляет  летнюю программу для детей и их родителей в самом сердце Кавказского Биосферного Заповедника раскинувшего свои просторы вдоль берега моря.</p> <p>Вы окунетесь в незабываемый мир стиля и светского этикета. Современная архитектура и элитарные  условия проживания, подарят вам, ни с чем несравнимое ощущение комфорта высшего общества. Летняя Школа станет для Вас прекрасным местом получения новых знаний в области международного бизнеса, всех видов этикета и дипломатического протокола. Мы создаем для Вас и ваших детей  атмосферу любви, романтики и душевного комфорта, воплощая все мечты и фантазии в реальность.</p> <p>Летняя школа Этикета в г.Сочи - это современный, мини-отель с максимальным комфортом. Нестандартная архитектура и лучшие технические решения в стиле hi-teck. Отель перенесет Вас от городской суеты, в самое сердце Кавказского Биосферного Заповедника. Всего 5 минут езды с нашим водителем и вы на берегу Черного моря. Время же в пути до центра города Сочи, займет не более 15 минут. Летняя школа Этикета – это ваш дом, где вдыхая чистый горный воздух, вы будете любоваться морем, до которого буквально можно дотянуться рукой. Писать пейзажи маслом, наслаждаясь утренним ароматом кофе на уникальной террасе, любоваться горными вершинами под чарующие звуки скрипки и фортепиано. Незабываемый закат, и вечеринки у шикарного бассейна, после которых Вы даже перед сном будете смотреть прямо на море... сквозь панорамные окна вашего уютного летнего дома.</p> <h3>Школа предлагает 2 летние программы для разных возрастов, которые включают в себя:</h3> <ul> <li><strong>интенсивный курс протокола</strong></li> <li><strong>этикета и искусства для взрослых и детей</strong></li> </ul> <h3>Первая летняя программа рассчитана  на детей в возрасте от  5 до  13 лет</h3> <ul> <li> Этикет и хорошие манеры (правила поведения в театре, в музее, на концерте; правила приветствия и общения; культура дарения подарков)</li> <li>Столовый этикет (правила поведения за столом, сервировка стола;  организация  собственного праздника)</li> <li>Элегантность  (Эстетика движения. Элегантность манер. Язык жестов: жесты уверенного человека. Как красиво ходить, вставать, сидеть, снимать  верхнюю одежду и  просто красиво двигаться)</li> <li>Детская йога (йога-терапия для позвоночника; медитативные практики; поддерживание физической формы благодаря динамическим позам и энергетическим комплексам упражнений; развитие концентрации у детей-дошкольников благодаря игровой форме занятий, позам животных и интересным историям для каждого комплекса упражнений;  способствование эмоциональному равновесию и спокойствия у подростков и детей; укрепление внутренних органов, развитие гибкости и координации)</li> <li>Актёрское мастерство (работа с голосом, речью и жестами; психология; раскрепощение личности; сценическое движение; постановка мини-спектаклей; перевоплощение образов)</li> <li>Живопись (история живописи; рисование в разных техниках живописи от постели до масла, рисование геометрических тел; гипсовые орнаменты; драпировка; натюрморт; теплые и холодные цвета, контраст и нюанс, колорит и выделение главного в картине, понятие второстепенного, планов)</li> <li>Фотостайлинг (Образ. Технология построения образа. Ассоциативный образ. Эмоции в кадре. Как показать нужные эмоции. Практика; Художественная выразительность кадра. Создание образа на фотосессии в зависимости от поставленных задач. Основы композиции. Геометрия тела. Типы фигур. Визуальная коррекция. Аксессуары)</li> <li>История искусств (Понимание общих принципов искусства; понятие стиля в искусстве; виды изобразительного и декоративно - прикладного искусства; история мировой скульптуры; роль искусства в формировании личности человека в историческом контексте; основные принципы архитектуры.)</li> <li>Имиджеология (Что такое элегантность; искусство самопрезентации; формирование личного стиля и его коррекция; персональный имидж; язык жестов; искусство быть леди; звуковая терапия и голосо-речевая гимнастика, ораторское мастерство и самопрезентация)</li> </ul> <h3>Вторая летняя программа более подойдет  для леди  от  18 лет</h3> <ul> <li>Гражданский Этикет. Хорошие манеры  (поведение за столом в разных странах; поведение за столом в ресторане, в отеле; планирование меню для приема гостей; беседа за столом; приглашение гостей, культура дарения подарков, поведение в театре и т.д. встреча гостей, телефонный этикет, обеденный дресс-код)</li> <li>Международный этикет для официальных, неофициальных, частных и деловых встреч (Особенности этикета каждой сраны; Основные отличия восточного этикета от этикета западного)</li> <li>Международный протокол (Встречи на высшем уровне; Приезд делегации или государственных деятелей, юбилейные мероприятия или по случаю знаменательного события; встречи «без галстуков»)</li> <li>Столовый этикет  (сервировка стола, подача вина, сорта вина и подходящие к ним блюда; уход за фарфором и серебром; частные вечеринки, сервировка чая, кофе; как поддержать разговор – принятые и запрещенные темы; правила международного протокола; вербальная экспрессия, язык жестов; дресс-код). Теоретические занятия сопровождаются практикой – организация чайной церемонии, коктейль-пати и т.д.- 6 уроков в неделю)</li> <li>Светский этикет (классические правила выхода в свет; знакомство на светских мероприятиях; правила дресс-кода  для званого ужина. Как общаться  с VIP-персонами,  желательные и нежелательные темы для светской беседы, все об элегантности, история и традиции сервировки стола)</li> <li>Бизнес-этикет (культура дарения подарков; этикет  делового общения; обмен визитными карточками; встречи и рукопожатия; ведение переговоров; Бизнес-презентации; деловые «денежные» обеды; деловые вечеринки; корреспонденция: особенности деловой переписки, написание резюме, офисный и телефонный этикет) – 6 уроков в неделю)</li> <li>Живопись на пленэре (Живопись на пленэре – это очень интересный способ научиться писать маслом при естественном освещении и при всей красе природы во всех ее проявлениях. Так же это позволит, что называется, воссоединиться с природой и ощутить всю её спокойствие и гармонию)</li> <li>Йога и пиллатес (Фитнес-йога удачно сочетает статические и динамические асаны, дыхательные упражнения, концентрацию внимания на работе мышц и деятельности внутренних органов. Результат — снятие стресса, улучшение гибкости и контроля над собственным телом и внутренним миром)</li> <li>Стилистика  (как сформировать индивидуальный стиль; цветовые принципы построения образа;  персональный подбор  фасонов и стилей; типы тканей, рисунки и аксессуары; как сформировать идеальный гардероб своему мужчине; последние тренды сезона;   как подобрать парфюм;   подбор аксессуаров; лучшие бренды и их знаковые черты)</li> </ul> <h4>За дополнительную плату можно изучать:</h4> <ul> <li>PR (связи с общественностью “public relations”)</li> <li>искусство представить себя</li> <li>украшение блюд</li> <li>бальные танцы</li> <li>верховая езда</li> <li>теннис</li> <li>доп. иностранные языки</li> </ul> <!--{{#if online}}--> <!--<h4>Вариант участия:</h4>--> <!--<div class="types">--> <!--<button class="item" data-type="live">Вживую</button>--> <!--{{#if online}}--> <!--<button class="item" data-type="webinar">Вебинар</button>--> <!--{{/if}}--> <!--{{#if gotVideo}}--> <!--<button class="item" data-type="video">Видеозапись</button>--> <!--{{/if}}--> <!--</div>--> <!--{{/if}}--> <!--<h4>Стоимость:</h4>--> <!--<h3 class="main-price">{{currentPrice}}</h3>-->',
    firstDate: 'с <span>24 мая</span> по <span>13 июня</span>',
    secondDate: 'с <span>14 июня</span> по <span>4 июля</span>',
    thirdDate: 'c <span>5 июля</span> по <span>24 августа</span>',
    disclaimer: 'Возможно проживание сразу несколько заездов',
    price: '78 500 р',
    priceExtended: '(цена проживания с завтраком <span class="price">56000р</span> + программа обучения <span class="price">25000р</span>)',
    priceList: '<li>Проживание с завтраком</li> <li>Авторская образовательная программа 4 часа каждый день, кроме выходных</li> <li>Йога и пилатес</li> <li>Расходные материалы для обучения</li> <li>Сертификат обучения</li> <li>Интернет</li> <li>Зал тренажеров</li> <li>Уборка номеров</li> <li>Лежаки и полотенца</li> <li>Ежедневный трансфер</li> <li>Экскурсии</li> <li>Развлекательная программа</li>',
    roomList: '<li>Удлиненные кровати (более 2 метров)</li> <li>Красивый вид на море</li> <li>Открытый плавательный бассейн</li> <li>Открытый бассейн (работает круглый год)</li> <li>Сад</li> <li>Терраса</li> <li>Терраса для загара</li> <li>Рыбная ловля</li> <li>Настольный теннис</li> <li>Пешие прогулки</li> <li>Сауна</li> <li>Фитнес-центр</li> <li>Массаж</li> <li>Гидромассажная ванна</li> <li>Частная пляжная зона</li> <li>Караоке</li> <li>Ночной клуб/Диджей</li>',
    mediaList: '<li>Телевизор с плоским экраном</li>',
    additionalList: '<li>Перелет</li> <li>Услуги SPA</li> <li>Услуги косметолога. На основе косметики ВВ Лабораторикс. Курс лечения на основе препарата «Лаеннек»  (Япония) по цене дистрибьютора. Пройдите лечение препаратом «Лаеннек» — и омолодите свой организм и тело на 10-15 лет!</li>',
    pansion: 'Возможен полный пансион (обед, ужин, разовое питание) - <span>2900р в день</span>',
    elseList: '<li>Wi-Fi предоставляется на территории всего отеля бесплатно</li> <li>Трансфер от/до аэропорта (бесплатный)</li> <li>Круглосуточная стойка регистрации</li> <li>Экскурсионное бюро</li> <li>Общий лаунж/гостиная с телевизором</li> <li>Прачечная</li> <li>Услуги по глажению одежды</li> <li>Ежедневная уборка номера</li> <li>Доставка прессы</li> <li>Сейф</li> <li>Номера для некурящих</li> <li>Звукоизолированные номера</li> <li>Отопление</li> <li>Москитная сетка</li> <li>Кондиционер</li> <li>Разрешается проживание детей любого возраста. Бесплатно!</li> <li>При размещении всех детей младше 2 лет на детских кроватках проживание им предоставляется бесплатно</li> <li>При размещении всех детей младше 12 лет на дополнительных кроватях взимается RUB 1000 за ночь</li> <li>При дополнительном размещении всех детей старшего возраста или взрослых на дополнительных кроватях взимается RUB 1500 за ночь</li> <li>Максимальное количество дополнительных кроватей в номере - 1</li>',
    disclaimer2: 'Дополнительные услуги не включаются автоматически в общую стоимость и оплачиваются отдельно во время вашего проживания'
  });
}

Meteor.startup(function() {
  var user, user2, user3;
  if (Meteor.users.find().count() === 0) {
    user = Accounts.createUser({
      username: 'ksusha',
      email: 'bastrikina2011@yandex.ru',
      password: '12345678',
      profile: {
        name: 'Ксения',
        surname: 'Бастрыкина',
        pic: 'ksusha.jpg'
      }
    });
    user2 = Accounts.createUser({
      username: 'masha',
      email: 'maria-skr-rt@mail.ru',
      password: '12345678',
      profile: {
        name: 'Мария',
        surname: 'Бастрыкина',
        pic: 'masha.jpg'
      }
    });
    user3 = Accounts.createUser({
      username: 'albert_kai',
      email: 'albertkai@me.com',
      password: '12345678',
      profile: {
        name: 'Альберт',
        surname: 'Кайгородов',
        pic: 'albert.jpg'
      }
    });
    Roles.addUsersToRoles(user, ['owner']);
    Roles.addUsersToRoles(user2, ['owner']);
    return Roles.addUsersToRoles(user3, ['admin']);
  }
});
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);


/* Exports */
if (typeof Package === 'undefined') Package = {};
Package['aura:core'] = {};

})();

//# sourceMappingURL=aura_core.js.map
