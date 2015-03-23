(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
if (Slider.find().count() === 0) {
  Slider.insert({
    pic: 'slider_1.jpg',
    desc: 'Школа основана под патронажем австрийской императрицы Sisi Elizabeth в 1867 году',
    href: '',
    order: 0
  });
  Slider.insert({
    pic: 'slider_2.jpg',
    desc: '<span>Увлекательные дисциплины для настоящих леди:</span> <span>этикет, иностранные языки, актерское мастерство, уроки высокой кухня и многое другое</span>',
    order: 1,
    href: '/children'
  });
  Slider.insert({
    pic: 'W7PBr2MFCMutyYTgv.jpg',
    desc: '<span>7 декабря</span> <span>&nbsp;в ресторане «Ginza» Австрийская Высшая Школа Леди дает мастер-класс по столовому этикету для детей.&nbsp;<br></span>',
    order: 2,
    href: '/events'
  });
  Slider.insert({
    pic: 'slider_4.jpg',
    desc: '<span>Международная программа:</span> <span>этикет с графиней Marie De Tilly, современное искусство с педагогами Sotheby\'s, актерское мастерство с Paul Brown</span>',
    order: 3,
    href: '/events'
  });
}

if (SummerSlider.find().count() === 0) {
  SummerSlider.insert({
    pic: 'dsc_6597.jpg',
    desc: 'Школа основана под патронажем австрийской императрицы Sisi Elizabeth в 1867 году',
    order: 0
  });
  SummerSlider.insert({
    pic: 'dsc_6607.jpg',
    desc: 'Текст слайдера',
    order: 1
  });
}

})();

//# sourceMappingURL=seed.coffee.js.map
