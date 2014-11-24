#
#AuraPages.remove {'_id': AuraPages.findOne({name: 'common'})._id}
#AuraPages.remove {'_id': AuraPages.findOne({name: 'index'})._id}
#AuraPages.remove {'_id': AuraPages.findOne({name: 'children'})._id}
#AuraPages.remove {'_id': AuraPages.findOne({name: 'teens'})._id}
#AuraPages.remove {'_id': AuraPages.findOne({name: 'lateTeens'})._id}
#AuraPages.remove {'_id': AuraPages.findOne({name: 'grownUps'})._id}
#if AuraPages.findOne({name: 'news'})
#  AuraPages.remove {'_id': AuraPages.findOne({name: 'news'})._id}
#if AuraPages.findOne({name: 'events'})
#  AuraPages.remove {'_id': AuraPages.findOne({name: 'events'})._id}

if AuraPages.find({name: 'common'}).count() is 0

  AuraPages.insert {
    name: 'common'
    phoneMain: '(812) 345-54-54'
    phoneSecond: '(812) 344-53-53'
    emailMain: 'info@sisi-elizabeth.com'
    address: 'Санкт-Петербург, Суворовский пр. 34, Austrian Higher School of Ladies'
    footerDesc: '<span><strong>2012-2014</strong> Austrian Higher School of Ladies. </span> Все права защищены.'
    vkLink: 'http://vk.com'
    facebookLink: 'http://facebook.com'
    twitterLink: 'http://twitter.com'
    instagramLink: 'http://instagram.com'
  }

if AuraPages.find({name: 'index'}).count() is 0

  AuraPages.insert {
    name: 'index'
    header1: 'О школе'
    header2: 'Новости'
    header3: 'Ближайшие события'
    header4: 'Расписание'
    header5: 'Партнеры'
    header6: 'Направления'
    slider: [
      {
        pic: 'slider_1.jpg'
        desc: 'Школа основана под патронажем австрийской императрицы Sisi Elizabeth в 1867 году'
      },
      {
        pic: 'slider_2.jpg'
        desc: '<span>Увлекательные дисциплины для настоящих леди:</span> <span>этикет, иностранные языки, актерское мастерство, уроки высокой кухня и многое другое</span>'
      },
      {
        pic: 'slider_3.jpg'
        desc: '<span>25 ноября</span> <span>при поддержке нашей школы пройдет мастер-класс Ирины Хакамада "Мастер общения. Успех без затрат"</span>'
      },
      {
        pic: 'slider_4.jpg'
        desc: '<span>Международная программа:</span> <span>этикет с графиней Marie De Tilly, современное искусство с педагогами Sotheby\'s, актерское мастерство с Paul Brown</span>'
      }
    ]
    mainDesc: '<p class="quot">
                            Австрийская Высшая Школа Леди была основана  в 1867 году под патронажем Австрийской императрицы Сиси Элизабет
                        </p>
                        <p>
                            Школа специализируется на обучении и профессиональной подготовке девушек из высшего общества по передовым международным образовательным программам в области искусства, дизайна, этикета и другим, необходимым для каждой леди, прикладным предметам.
                            Австрийская Высшая Школа Леди в  г. Санкт-Петербург является одним из важнейших образовательных центров России для девушек, специализирующаяся на профессиональном образовании в сфере творческих и гуманитарных дисциплин.
                        </p>
                        <p> В основе развития данного образовательного центра лежит тесная партнерская связь с творческими и культурными нововведениями международного сообщества. По окончании института лишь шесть лучших выпускниц (подростковой группы)  получат  «шифр» - золотой вензель в виде инициала императрицы  Сиси Елизабет, и примут участие в выпускном бале в качестве  дебютанток в Венском Ховбурге.</p>
                        <p>Уникальное преимущество Австрийской Высшей Школы Леди  заключается в возможности получения высшего образования для  девушек в России в соответствии со строжайшими международными стандартами. Эту возможность предоставляют учебные программы, аккредитованные  Quality Assurance Agency - независимым агентством по контролю качества высшего образования. Основной принцип заключается в том, что курсы австрийского образования, предлагаемые в России, проводятся, в большинстве своем, иностранными профессионалами в своей сфере. </p>'


  }


if AuraPages.find({name: 'contacts'}).count() is 0

  AuraPages.insert {
    name: 'contacts'
    emailMain: 'ladiesschool@me.com - <span>менеджер</span>'
    emailSecondary: 'ladiesschool@me.com - <span>для записи</span>'
    phoneHeader: 'Телефон:'
    emailHeader: 'E-mail:'
    addressHeader: 'Адрес:'
    allQuestions: 'По всем вопросам звоните:'
    weWillContactU: 'Либо оставьте нам заявку, и мы свяжемся с вами в ближайшее время:'
  }

if AuraPages.find({name: 'children'}).count() is 0

  AuraPages.insert {
    name: 'children'
    heading: '<span>Детская</span><span>группа</span>'
    mainPic: 'direction_bg3.jpg'
    indexDesc: 'группа для маленьких принцесс блабла'
    mainDesc: '<p>	Леди, которая сегодня вызывает восхищение, еще вчера была девочкой лет 4-х… Как же происходит эта сказочная метаморфоза?</p><p> Все ценное закладывается  в детстве! Поэтому мы маленьких леди обучаем этикету  - как представиться, как попрощаться, за что отвечает каждая ложечка на столе…  Мы любуемся импрессионистами  и рисуем полет бабочки. Мы изучаем по сказкам Европы историю костюма!  Мы учимся красиво и без конфликта заявлять права на свою куклу в саду. Мы позируем … Играем в театр… И конечно, впервые открываем волшебный мир гардеробной. </p>'
    mainQuot: 'Австрийская Высшая Школа Леди в  г. Санкт-Петербург является одним из важнейших образовательных центров России для девочек  и девушек'
    classes: [
      {
        name: 'Этикет'
        desc: '<p class="quot">Как представиться. Как поприветствовать. Как попрощаться. В столовом этикете малыши будут изучать роль каждого столового прибора. И учиться пить чай по книгам Льюиса Кэролла</p> <p>Основные темы – столовый этикет и этикет общения. Программа этикета и хороших манер поможет развить устойчивые поведенческие навыки, которые позволят в дальнейшем чувствовать себя уверенно в любой ситуации, связанной с  общением. </p>'
        pic: 'etiket.jpg'
      },
      {
        name: 'Стилистика',
        desc: '<p class="quot"> История костюма изучается по сказкам, по полотнам известных художников. Стили и стилевые направления для маленьких леди открываются через бренды, создающие коллекции для детей – от Dior до Dolce & Gabbana! </p><p>Они научатся отличать классический стиль от фольклорного, романтический от casual  и многое другое. Также мы будем изучать на практике гардероб настоящей Леди! Изучим темы от цвета (а ведь у каждого свой характер! И не все цвета хотят дружить друг с другом!) до сказочной темы шляпок и не только! </p>'
        pic: 'stilistika.jpg'
      },
      {
        name: 'Имиджеология'
        desc: '<p>Девочки овладеют навыками искусства  самопрезентации с помощью практических занятий.. Узнают секреты как оставить  положительное впечатление в памяти своих друзей. Определят  свои сильные качества и  узнают  как их использовать в их детском мире. Научаться различать имидж плохого и хорошего героя на примере сказок. Узнают как формируется имидж в классе или в детском саду. Из чего имидж складывается, как формируется и как управляется.  </p>'
        pic: 'imidzeologia.jpg'
      },
      {
        name: 'Верховая езда'
        desc: '<p class="quot"> Уроки верховой езды   проходят  в элитном конно-спортивном  клубе  «ДЕРБИ», расположенном  в живописном уголке Ленинградской области.  Ведь каждая будущая леди должна уметь уверенно держаться в седле, легко управляться с лошадью и вести светскую беседу.</p><p>Девочкам проводится краткий рассказ об истории отношений человека и лошади.  Первоначальные  практические занятия включают в себя  обучение правильной посадке, основам управления  </p>'
        pic: 'verhovaya.jpg'
      },
      {
        name: 'Актерское мастерство'
        desc: '<p class="quot">Актерское мастерство - это быстрый и увлекательный способ научиться спонтанной импровизации.</p><p>В течение учебного процесса  девочки освободятся   от комплексов и  зажатости,  разовьют  в себе наблюдательность и вовлеченность в творческий процесс, а так же обретут  уверенность в себе. На практических занятиях девочки будут перевоплощаться в различные образы и готовить небольшие спектакли для благодарной родительской аудитории.  </p>'
        pic: 'akterskoe.jpg'
      },
      {
        name: 'Хореография'
        desc: '<p class="quot">Главным достижением на уроках хореографии это – правильная осанка, пластичность, грациозность и легкость движений, уравновешенность, улучшение способности концентрироваться, укрепление здоровья, формирование сильного и гибкого тела.</p><p>В программу занятий входят упражнения по укреплению мышц и развития пластичности, постановку правильной осанки, походки, увеличения эластичности связок (растяжки), включая игровые и танцевальные элементы. </p>'
        pic: 'horeografia.jpg'
      },
      {
        name: 'Английский язык'
        desc: '<p class="quot">Все занятия  проходят  в игровой форме. Девочки с легкостью  запоминают  новые иностранные слова с помощью пения, игры, рисования  и многого другого.   Особое внимание при этом  уделяется живому общению и произношению. </p><p>Занятия  проходят  в уютной располагающей атмосфере, где педагоги  создают дружелюбную мотивирующую атмосферу, чтобы дети полюбили занятия. В классах создается  живая  англоговорящая  среда, где малышки  учатся говорить, понимать и думать на английском.</p>'
        pic: 'angliyskiy.jpg'
      },
      {
        name: 'Фотостайлинг'
        desc: '<p>Модные  наряды, легкая и грациозная походка, правильная осанка, отточенные движения и бесконечные фотовспышки, все это сопровождает результаты труда детского творчества. Девочки учатся правильно держаться перед камерой, позировать модному фотографу и не бояться  ярких вспышек камер. </p>'
        pic: 'foto.jpg'
      },
      {
        name: 'Уроки высокой кухни'
        desc: '<p>Кулинарные кутюрье поделаться с будущими леди тайнами своему ремесла, и девочки сами смогут сотворить шедевр собственными руками на радость себе и своим близким. Домой они принесут вкусное печенье, пирожные и разные другие лакомства. </p>',
        pic: 'kuhna.jpg'
      },
      {
        name: 'Дефиле'
        desc: '<p class="quot">Девочки освоят  навыки поведения на сцене. Занятия помогут им правильно  держать осанку,  красиво двигаться и дефилировать в разных тематических стилях.</p><p>Прежде всего, уроки дефиле помогают раскрыть яркую индивидуальность  девочек и, конечно же,   позволяют  маленьким леди демонстрировать   костюмы и наряды во всем их блеске и разнообразии. Каждое практическое занятие  заканчивается  фееричным и запоминающимся  для  детей выступлением.</p>'
        pic: 'defile.jpg'
      },
      {
        name: 'Истроия искусств'
        desc: '<p class="quot">Малышки научатся  общаться с окружающим миром, с культурной средой.  Познакомятся с  самым  оптимистическим направлением в живописи как  Импрессионизм.</p><p>Девочки   научатся погружаться в переживание цвета и переживание души.  Уроки помогут  ученицам  стать  разносторонней личностью, развить  свои  таланты и научатся   понимать  себя и окружающий мир.  </p>'
        pic: 'istoria.jpg'
      },
      {
        name: 'Психология'
        desc: '<p>Как известно, психология – это зонтик от неприятностей в любую погоду. Мы будем учиться выходить без конфликтов из спорных ситуаций. Будем учиться общаться! Как правильно сказать о своих потребностях. Как выразить свои чувства. Как помириться и как подружиться!</p>',
        pic: 'psichologia.jpg'
      },
      {
        name: 'Детские мероприятия и балы'
        desc: '<p>в течение всего периода обучения девочки  посещают  светские  и культурные  мероприятия для детей своего возраста, которые помогают  маленьким леди  продемонстрировать в обществе свои  навыки  и умения, приобретенные в школе.  И конечно же получить яркие эмоции и впечатления  от детских праздников.</p>'
        pic: 'meropriatia.jpeg'
      }
    ]

  }


if AuraPages.find({name: 'news'}).count() is 0

  AuraPages.insert {
    name: 'news'
    news: [
      {
        date: '25.11.2014'
        title: 'Мастер-класс Ирина Хакамада "Мастер общения. Успех без затрат"'
        pic: 'hak_new.jpg'
      },
      {
        date: '22.11.2014'
        title: 'Мастер-класс известного российского художника Александра Кравчука'
        pic: 'kra.jpg'
      },
      {
        date: '07.12.2014'
        title: 'Детский бал'
        pic: 'bal.jpg'
      }
    ]
  }

if AuraPages.find({name: 'events'}).count() is 0

  AuraPages.insert {
    name: 'events'
    events: [
      {
        date: '25.11.2014'
        title: 'Мастер-класс Ирина Хакамада "Мастер общения. Успех без затрат"'
        pic: 'hak_new.jpg'
      },
      {
        date: '22.11.2014'
        title: 'Мастер-класс известного российского художника Александра Кравчука'
        pic: 'kra.jpg'
      },
      {
        date: '07.12.2014'
        title: 'Детский бал'
        pic: 'bal.jpg'
      }
    ]
  }


if AuraPages.find({name: 'teens'}).count() is 0

  AuraPages.insert {
    name: 'teens'
    heading: '<span>Школьная</span><span>группа</span>'
    mainPic: 'direction_bg3.jpg'
    indexDesc: 'группа для маленьких принцесс блабла'
    mainDesc: '<p>	Леди, которая сегодня вызывает восхищение, еще вчера была девочкой лет 4-х… Как же происходит эта сказочная метаморфоза?</p><p> Все ценное закладывается  в детстве! Поэтому мы маленьких леди обучаем этикету  - как представиться, как попрощаться, за что отвечает каждая ложечка на столе…  Мы любуемся импрессионистами  и рисуем полет бабочки. Мы изучаем по сказкам Европы историю костюма!  Мы учимся красиво и без конфликта заявлять права на свою куклу в саду. Мы позируем … Играем в театр… И конечно, впервые открываем волшебный мир гардеробной. </p>'
    mainQuot: 'Австрийская Высшая Школа Леди в  г. Санкт-Петербург является одним из важнейших образовательных центров России для девочек  и девушек'
    classes: [
      {
        name: 'Этикет'
        desc: '<p class="quot">Как представиться. Как поприветствовать. Как попрощаться. В столовом этикете малыши будут изучать роль каждого столового прибора. И учиться пить чай по книгам Льюиса Кэролла</p> <p>Основные темы – столовый этикет и этикет общения. Программа этикета и хороших манер поможет развить устойчивые поведенческие навыки, которые позволят в дальнейшем чувствовать себя уверенно в любой ситуации, связанной с  общением. </p>'
        pic: 'etiket.jpg'
      },
      {
        name: 'Стилистика',
        desc: '<p class="quot"> История костюма изучается по сказкам, по полотнам известных художников. Стили и стилевые направления для маленьких леди открываются через бренды, создающие коллекции для детей – от Dior до Dolce & Gabbana! </p><p>Они научатся отличать классический стиль от фольклорного, романтический от casual  и многое другое. Также мы будем изучать на практике гардероб настоящей Леди! Изучим темы от цвета (а ведь у каждого свой характер! И не все цвета хотят дружить друг с другом!) до сказочной темы шляпок и не только! </p>'
        pic: 'stilistika.jpg'
      },
      {
        name: 'Имиджеология'
        desc: '<p>Девочки овладеют навыками искусства  самопрезентации с помощью практических занятий.. Узнают секреты как оставить  положительное впечатление в памяти своих друзей. Определят  свои сильные качества и  узнают  как их использовать в их детском мире. Научаться различать имидж плохого и хорошего героя на примере сказок. Узнают как формируется имидж в классе или в детском саду. Из чего имидж складывается, как формируется и как управляется.  </p>'
        pic: 'imidzeologia.jpg'
      },
      {
        name: 'Верховая езда'
        desc: '<p class="quot"> Уроки верховой езды   проходят  в элитном конно-спортивном  клубе  «ДЕРБИ», расположенном  в живописном уголке Ленинградской области.  Ведь каждая будущая леди должна уметь уверенно держаться в седле, легко управляться с лошадью и вести светскую беседу.</p><p>Девочкам проводится краткий рассказ об истории отношений человека и лошади.  Первоначальные  практические занятия включают в себя  обучение правильной посадке, основам управления  </p>'
        pic: 'verhovaya.jpg'
      },
      {
        name: 'Актерское мастерство'
        desc: '<p class="quot">Актерское мастерство - это быстрый и увлекательный способ научиться спонтанной импровизации.</p><p>В течение учебного процесса  девочки освободятся   от комплексов и  зажатости,  разовьют  в себе наблюдательность и вовлеченность в творческий процесс, а так же обретут  уверенность в себе. На практических занятиях девочки будут перевоплощаться в различные образы и готовить небольшие спектакли для благодарной родительской аудитории.  </p>'
        pic: 'akterskoe.jpg'
      },
      {
        name: 'Хореография'
        desc: '<p class="quot">Главным достижением на уроках хореографии это – правильная осанка, пластичность, грациозность и легкость движений, уравновешенность, улучшение способности концентрироваться, укрепление здоровья, формирование сильного и гибкого тела.</p><p>В программу занятий входят упражнения по укреплению мышц и развития пластичности, постановку правильной осанки, походки, увеличения эластичности связок (растяжки), включая игровые и танцевальные элементы. </p>'
        pic: 'horeografia.jpg'
      },
      {
        name: 'Английский язык'
        desc: '<p class="quot">Все занятия  проходят  в игровой форме. Девочки с легкостью  запоминают  новые иностранные слова с помощью пения, игры, рисования  и многого другого.   Особое внимание при этом  уделяется живому общению и произношению. </p><p>Занятия  проходят  в уютной располагающей атмосфере, где педагоги  создают дружелюбную мотивирующую атмосферу, чтобы дети полюбили занятия. В классах создается  живая  англоговорящая  среда, где малышки  учатся говорить, понимать и думать на английском.</p>'
        pic: 'angliyskiy.jpg'
      },
      {
        name: 'Фотостайлинг'
        desc: '<p>Модные  наряды, легкая и грациозная походка, правильная осанка, отточенные движения и бесконечные фотовспышки, все это сопровождает результаты труда детского творчества. Девочки учатся правильно держаться перед камерой, позировать модному фотографу и не бояться  ярких вспышек камер. </p>'
        pic: 'foto.jpg'
      },
      {
        name: 'Уроки высокой кухни'
        desc: '<p>Кулинарные кутюрье поделаться с будущими леди тайнами своему ремесла, и девочки сами смогут сотворить шедевр собственными руками на радость себе и своим близким. Домой они принесут вкусное печенье, пирожные и разные другие лакомства. </p>',
        pic: 'kuhna.jpg'
      },
      {
        name: 'Дефиле'
        desc: '<p class="quot">Девочки освоят  навыки поведения на сцене. Занятия помогут им правильно  держать осанку,  красиво двигаться и дефилировать в разных тематических стилях.</p><p>Прежде всего, уроки дефиле помогают раскрыть яркую индивидуальность  девочек и, конечно же,   позволяют  маленьким леди демонстрировать   костюмы и наряды во всем их блеске и разнообразии. Каждое практическое занятие  заканчивается  фееричным и запоминающимся  для  детей выступлением.</p>'
        pic: 'defile.jpg'
      },
      {
        name: 'Истроия искусств'
        desc: '<p class="quot">Малышки научатся  общаться с окружающим миром, с культурной средой.  Познакомятся с  самым  оптимистическим направлением в живописи как  Импрессионизм.</p><p>Девочки   научатся погружаться в переживание цвета и переживание души.  Уроки помогут  ученицам  стать  разносторонней личностью, развить  свои  таланты и научатся   понимать  себя и окружающий мир.  </p>'
        pic: 'istoria.jpg'
      },
      {
        name: 'Психология'
        desc: '<p>Как известно, психология – это зонтик от неприятностей в любую погоду. Мы будем учиться выходить без конфликтов из спорных ситуаций. Будем учиться общаться! Как правильно сказать о своих потребностях. Как выразить свои чувства. Как помириться и как подружиться!</p>',
        pic: 'psichologia.jpg'
      },
      {
        name: 'Детские мероприятия и балы'
        desc: '<p>в течение всего периода обучения девочки  посещают  светские  и культурные  мероприятия для детей своего возраста, которые помогают  маленьким леди  продемонстрировать в обществе свои  навыки  и умения, приобретенные в школе.  И конечно же получить яркие эмоции и впечатления  от детских праздников.</p>'
        pic: 'meropriatia.jpeg'
      }
    ]

  }


if AuraPages.find({name: 'lateTeens'}).count() is 0

  AuraPages.insert {
    name: 'lateTeens'
    heading: '<span>Подростковая</span><span>группа</span>'
    mainPic: 'direction_bg3.jpg'
    indexDesc: 'группа для маленьких принцесс блабла'
    mainDesc: '<p>	Леди, которая сегодня вызывает восхищение, еще вчера была девочкой лет 4-х… Как же происходит эта сказочная метаморфоза?</p><p> Все ценное закладывается  в детстве! Поэтому мы маленьких леди обучаем этикету  - как представиться, как попрощаться, за что отвечает каждая ложечка на столе…  Мы любуемся импрессионистами  и рисуем полет бабочки. Мы изучаем по сказкам Европы историю костюма!  Мы учимся красиво и без конфликта заявлять права на свою куклу в саду. Мы позируем … Играем в театр… И конечно, впервые открываем волшебный мир гардеробной. </p>'
    mainQuot: 'Австрийская Высшая Школа Леди в  г. Санкт-Петербург является одним из важнейших образовательных центров России для девочек  и девушек'
    classes: [
      {
        name: 'Этикет'
        desc: '<p class="quot">Как представиться. Как поприветствовать. Как попрощаться. В столовом этикете малыши будут изучать роль каждого столового прибора. И учиться пить чай по книгам Льюиса Кэролла</p> <p>Основные темы – столовый этикет и этикет общения. Программа этикета и хороших манер поможет развить устойчивые поведенческие навыки, которые позволят в дальнейшем чувствовать себя уверенно в любой ситуации, связанной с  общением. </p>'
        pic: 'etiket.jpg'
      },
      {
        name: 'Стилистика',
        desc: '<p class="quot"> История костюма изучается по сказкам, по полотнам известных художников. Стили и стилевые направления для маленьких леди открываются через бренды, создающие коллекции для детей – от Dior до Dolce & Gabbana! </p><p>Они научатся отличать классический стиль от фольклорного, романтический от casual  и многое другое. Также мы будем изучать на практике гардероб настоящей Леди! Изучим темы от цвета (а ведь у каждого свой характер! И не все цвета хотят дружить друг с другом!) до сказочной темы шляпок и не только! </p>'
        pic: 'stilistika.jpg'
      },
      {
        name: 'Имиджеология'
        desc: '<p>Девочки овладеют навыками искусства  самопрезентации с помощью практических занятий.. Узнают секреты как оставить  положительное впечатление в памяти своих друзей. Определят  свои сильные качества и  узнают  как их использовать в их детском мире. Научаться различать имидж плохого и хорошего героя на примере сказок. Узнают как формируется имидж в классе или в детском саду. Из чего имидж складывается, как формируется и как управляется.  </p>'
        pic: 'imidzeologia.jpg'
      },
      {
        name: 'Верховая езда'
        desc: '<p class="quot"> Уроки верховой езды   проходят  в элитном конно-спортивном  клубе  «ДЕРБИ», расположенном  в живописном уголке Ленинградской области.  Ведь каждая будущая леди должна уметь уверенно держаться в седле, легко управляться с лошадью и вести светскую беседу.</p><p>Девочкам проводится краткий рассказ об истории отношений человека и лошади.  Первоначальные  практические занятия включают в себя  обучение правильной посадке, основам управления  </p>'
        pic: 'verhovaya.jpg'
      },
      {
        name: 'Актерское мастерство'
        desc: '<p class="quot">Актерское мастерство - это быстрый и увлекательный способ научиться спонтанной импровизации.</p><p>В течение учебного процесса  девочки освободятся   от комплексов и  зажатости,  разовьют  в себе наблюдательность и вовлеченность в творческий процесс, а так же обретут  уверенность в себе. На практических занятиях девочки будут перевоплощаться в различные образы и готовить небольшие спектакли для благодарной родительской аудитории.  </p>'
        pic: 'akterskoe.jpg'
      },
      {
        name: 'Хореография'
        desc: '<p class="quot">Главным достижением на уроках хореографии это – правильная осанка, пластичность, грациозность и легкость движений, уравновешенность, улучшение способности концентрироваться, укрепление здоровья, формирование сильного и гибкого тела.</p><p>В программу занятий входят упражнения по укреплению мышц и развития пластичности, постановку правильной осанки, походки, увеличения эластичности связок (растяжки), включая игровые и танцевальные элементы. </p>'
        pic: 'horeografia.jpg'
      },
      {
        name: 'Английский язык'
        desc: '<p class="quot">Все занятия  проходят  в игровой форме. Девочки с легкостью  запоминают  новые иностранные слова с помощью пения, игры, рисования  и многого другого.   Особое внимание при этом  уделяется живому общению и произношению. </p><p>Занятия  проходят  в уютной располагающей атмосфере, где педагоги  создают дружелюбную мотивирующую атмосферу, чтобы дети полюбили занятия. В классах создается  живая  англоговорящая  среда, где малышки  учатся говорить, понимать и думать на английском.</p>'
        pic: 'angliyskiy.jpg'
      },
      {
        name: 'Фотостайлинг'
        desc: '<p>Модные  наряды, легкая и грациозная походка, правильная осанка, отточенные движения и бесконечные фотовспышки, все это сопровождает результаты труда детского творчества. Девочки учатся правильно держаться перед камерой, позировать модному фотографу и не бояться  ярких вспышек камер. </p>'
        pic: 'foto.jpg'
      },
      {
        name: 'Уроки высокой кухни'
        desc: '<p>Кулинарные кутюрье поделаться с будущими леди тайнами своему ремесла, и девочки сами смогут сотворить шедевр собственными руками на радость себе и своим близким. Домой они принесут вкусное печенье, пирожные и разные другие лакомства. </p>',
        pic: 'kuhna.jpg'
      },
      {
        name: 'Дефиле'
        desc: '<p class="quot">Девочки освоят  навыки поведения на сцене. Занятия помогут им правильно  держать осанку,  красиво двигаться и дефилировать в разных тематических стилях.</p><p>Прежде всего, уроки дефиле помогают раскрыть яркую индивидуальность  девочек и, конечно же,   позволяют  маленьким леди демонстрировать   костюмы и наряды во всем их блеске и разнообразии. Каждое практическое занятие  заканчивается  фееричным и запоминающимся  для  детей выступлением.</p>'
        pic: 'defile.jpg'
      },
      {
        name: 'Истроия искусств'
        desc: '<p class="quot">Малышки научатся  общаться с окружающим миром, с культурной средой.  Познакомятся с  самым  оптимистическим направлением в живописи как  Импрессионизм.</p><p>Девочки   научатся погружаться в переживание цвета и переживание души.  Уроки помогут  ученицам  стать  разносторонней личностью, развить  свои  таланты и научатся   понимать  себя и окружающий мир.  </p>'
        pic: 'istoria.jpg'
      },
      {
        name: 'Психология'
        desc: '<p>Как известно, психология – это зонтик от неприятностей в любую погоду. Мы будем учиться выходить без конфликтов из спорных ситуаций. Будем учиться общаться! Как правильно сказать о своих потребностях. Как выразить свои чувства. Как помириться и как подружиться!</p>',
        pic: 'psichologia.jpg'
      },
      {
        name: 'Детские мероприятия и балы'
        desc: '<p>в течение всего периода обучения девочки  посещают  светские  и культурные  мероприятия для детей своего возраста, которые помогают  маленьким леди  продемонстрировать в обществе свои  навыки  и умения, приобретенные в школе.  И конечно же получить яркие эмоции и впечатления  от детских праздников.</p>'
        pic: 'meropriatia.jpeg'
      }
    ]

  }



if AuraPages.find({name: 'grownUps'}).count() is 0

  AuraPages.insert {
    name: 'grownUps'
    heading: '<span>Взрослая</span><span>группа</span>'
    indexDesc: 'группа для маленьких принцесс блабла'
    mainPic: 'direction_bg3.jpg'
    mainDesc: '<p>	Леди, которая сегодня вызывает восхищение, еще вчера была девочкой лет 4-х… Как же происходит эта сказочная метаморфоза?</p><p> Все ценное закладывается  в детстве! Поэтому мы маленьких леди обучаем этикету  - как представиться, как попрощаться, за что отвечает каждая ложечка на столе…  Мы любуемся импрессионистами  и рисуем полет бабочки. Мы изучаем по сказкам Европы историю костюма!  Мы учимся красиво и без конфликта заявлять права на свою куклу в саду. Мы позируем … Играем в театр… И конечно, впервые открываем волшебный мир гардеробной. </p>'
    mainQuot: 'Австрийская Высшая Школа Леди в  г. Санкт-Петербург является одним из важнейших образовательных центров России для девочек  и девушек'
    classes: [
      {
        name: 'Этикет'
        desc: '<p class="quot">Как представиться. Как поприветствовать. Как попрощаться. В столовом этикете малыши будут изучать роль каждого столового прибора. И учиться пить чай по книгам Льюиса Кэролла</p> <p>Основные темы – столовый этикет и этикет общения. Программа этикета и хороших манер поможет развить устойчивые поведенческие навыки, которые позволят в дальнейшем чувствовать себя уверенно в любой ситуации, связанной с  общением. </p>'
        pic: 'etiket.jpg'
      },
      {
        name: 'Стилистика',
        desc: '<p class="quot"> История костюма изучается по сказкам, по полотнам известных художников. Стили и стилевые направления для маленьких леди открываются через бренды, создающие коллекции для детей – от Dior до Dolce & Gabbana! </p><p>Они научатся отличать классический стиль от фольклорного, романтический от casual  и многое другое. Также мы будем изучать на практике гардероб настоящей Леди! Изучим темы от цвета (а ведь у каждого свой характер! И не все цвета хотят дружить друг с другом!) до сказочной темы шляпок и не только! </p>'
        pic: 'stilistika.jpg'
      },
      {
        name: 'Имиджеология'
        desc: '<p>Девочки овладеют навыками искусства  самопрезентации с помощью практических занятий.. Узнают секреты как оставить  положительное впечатление в памяти своих друзей. Определят  свои сильные качества и  узнают  как их использовать в их детском мире. Научаться различать имидж плохого и хорошего героя на примере сказок. Узнают как формируется имидж в классе или в детском саду. Из чего имидж складывается, как формируется и как управляется.  </p>'
        pic: 'imidzeologia.jpg'
      },
      {
        name: 'Верховая езда'
        desc: '<p class="quot"> Уроки верховой езды   проходят  в элитном конно-спортивном  клубе  «ДЕРБИ», расположенном  в живописном уголке Ленинградской области.  Ведь каждая будущая леди должна уметь уверенно держаться в седле, легко управляться с лошадью и вести светскую беседу.</p><p>Девочкам проводится краткий рассказ об истории отношений человека и лошади.  Первоначальные  практические занятия включают в себя  обучение правильной посадке, основам управления  </p>'
        pic: 'verhovaya.jpg'
      },
      {
        name: 'Актерское мастерство'
        desc: '<p class="quot">Актерское мастерство - это быстрый и увлекательный способ научиться спонтанной импровизации.</p><p>В течение учебного процесса  девочки освободятся   от комплексов и  зажатости,  разовьют  в себе наблюдательность и вовлеченность в творческий процесс, а так же обретут  уверенность в себе. На практических занятиях девочки будут перевоплощаться в различные образы и готовить небольшие спектакли для благодарной родительской аудитории.  </p>'
        pic: 'akterskoe.jpg'
      },
      {
        name: 'Хореография'
        desc: '<p class="quot">Главным достижением на уроках хореографии это – правильная осанка, пластичность, грациозность и легкость движений, уравновешенность, улучшение способности концентрироваться, укрепление здоровья, формирование сильного и гибкого тела.</p><p>В программу занятий входят упражнения по укреплению мышц и развития пластичности, постановку правильной осанки, походки, увеличения эластичности связок (растяжки), включая игровые и танцевальные элементы. </p>'
        pic: 'horeografia.jpg'
      },
      {
        name: 'Английский язык'
        desc: '<p class="quot">Все занятия  проходят  в игровой форме. Девочки с легкостью  запоминают  новые иностранные слова с помощью пения, игры, рисования  и многого другого.   Особое внимание при этом  уделяется живому общению и произношению. </p><p>Занятия  проходят  в уютной располагающей атмосфере, где педагоги  создают дружелюбную мотивирующую атмосферу, чтобы дети полюбили занятия. В классах создается  живая  англоговорящая  среда, где малышки  учатся говорить, понимать и думать на английском.</p>'
        pic: 'angliyskiy.jpg'
      },
      {
        name: 'Фотостайлинг'
        desc: '<p>Модные  наряды, легкая и грациозная походка, правильная осанка, отточенные движения и бесконечные фотовспышки, все это сопровождает результаты труда детского творчества. Девочки учатся правильно держаться перед камерой, позировать модному фотографу и не бояться  ярких вспышек камер. </p>'
        pic: 'foto.jpg'
      },
      {
        name: 'Уроки высокой кухни'
        desc: '<p>Кулинарные кутюрье поделаться с будущими леди тайнами своему ремесла, и девочки сами смогут сотворить шедевр собственными руками на радость себе и своим близким. Домой они принесут вкусное печенье, пирожные и разные другие лакомства. </p>',
        pic: 'kuhna.jpg'
      },
      {
        name: 'Дефиле'
        desc: '<p class="quot">Девочки освоят  навыки поведения на сцене. Занятия помогут им правильно  держать осанку,  красиво двигаться и дефилировать в разных тематических стилях.</p><p>Прежде всего, уроки дефиле помогают раскрыть яркую индивидуальность  девочек и, конечно же,   позволяют  маленьким леди демонстрировать   костюмы и наряды во всем их блеске и разнообразии. Каждое практическое занятие  заканчивается  фееричным и запоминающимся  для  детей выступлением.</p>'
        pic: 'defile.jpg'
      },
      {
        name: 'Истроия искусств'
        desc: '<p class="quot">Малышки научатся  общаться с окружающим миром, с культурной средой.  Познакомятся с  самым  оптимистическим направлением в живописи как  Импрессионизм.</p><p>Девочки   научатся погружаться в переживание цвета и переживание души.  Уроки помогут  ученицам  стать  разносторонней личностью, развить  свои  таланты и научатся   понимать  себя и окружающий мир.  </p>'
        pic: 'istoria.jpg'
      },
      {
        name: 'Психология'
        desc: '<p>Как известно, психология – это зонтик от неприятностей в любую погоду. Мы будем учиться выходить без конфликтов из спорных ситуаций. Будем учиться общаться! Как правильно сказать о своих потребностях. Как выразить свои чувства. Как помириться и как подружиться!</p>',
        pic: 'psichologia.jpg'
      },
      {
        name: 'Детские мероприятия и балы'
        desc: '<p>в течение всего периода обучения девочки  посещают  светские  и культурные  мероприятия для детей своего возраста, которые помогают  маленьким леди  продемонстрировать в обществе свои  навыки  и умения, приобретенные в школе.  И конечно же получить яркие эмоции и впечатления  от детских праздников.</p>'
        pic: 'meropriatia.jpeg'
      }
    ]

  }


#Meteor.users.find().fetch().forEach (u)->
#  Meteor.users.remove {'_id': u._id}

#Creating users

Meteor.startup ->

  if Meteor.users.find().count() is 0

    user = Accounts.createUser {
        username: 'ksusha'
        email: 'bastrikina2011@yandex.ru'
        password: '12345678'
        profile: {
          name: 'Ксения',
          surname: 'Бастрыкина',
          pic: 'ksusha.jpg'
        }
      }

    user2 = Accounts.createUser {
      username: 'masha'
      email: 'maria-skr-rt@mail.ru'
      password: '12345678'
      profile: {
        name: 'Мария',
        surname: 'Бастрыкина',
        pic: 'masha.jpg'
      }
    }

    user3 = Accounts.createUser {
      username: 'albert_kai'
      email: 'albertkai@me.com'
      password: '12345678'
      profile: {
        name: 'Альберт',
        surname: 'Кайгородов',
        pic: 'albert.jpg'
      }
    }

    Roles.addUsersToRoles(user, ['owner'])
    Roles.addUsersToRoles(user2, ['owner'])
    Roles.addUsersToRoles(user3, ['admin'])

  console.log AuraPages.find().fetch()
  console.log 'hello'

