#Voted.find().forEach (v)->
#  Voted.remove(v._id)

#Girls.find().forEach (g)->
#  Girls.remove g._id
#
#if Girls.find().count() is 0
#
#  Girls.insert
#    name: 'Юлия'
#    surname: 'Игнатова'
#    pic: 'images/julia.jpg'
#    video: "https://www.youtube.com/embed/JW096HsG6Cw"
#    thumb: 'anna.png'
#    text: 'dfg'
#    votes: 0
#    juri: 20
#
#  Girls.insert
#    name: 'Яна'
#    surname: 'Александрова'
#    pic: 'images/yana.jpg'
#    video: "https://www.youtube.com/embed/dcQ-RtXDFE4"
#    thumb: 'svetlana.png'
#    text: 'dsfgdsfhg'
#    votes: 0
#    juri: 54
#
#  Girls.insert
#    name: 'Зарина'
#    surname: 'Рамазанова'
#    pic: 'images/zarina.jpg'
#    video: "https://www.youtube.com/embed/CShEbzU2yvI"
#    thumb: 'gaza.png'
#    text: 'Быть примером для современных девушек – та ответственность, с которой не каждая безукоризненно справится. Я искренне верю в силу улыбки и считаю ее своим главным оружием. Организованность, чувство меры и прирожденный такт помогают мне добиваться профессиональных высот. Будучи руководителем департамента бронирования крупнейшего ресторанного холдинга Санкт-Петербурга, я знаю, как расположить к себе даже самого «капризного» гостя. Сейчас я занимаюсь обучением и подготовкой профессионалов в ресторанной индустрии, но не забываю и о самообразовании – частый гость бизнес-тренингов и курсов повышения квалификации. В свободное от работы и учебы время я провожу за живописью – это помогает мне поддерживать гармоничное состояние внутри себя. Среди любимых видов спорта на первом месте, пожалуй, самый аристократический – верховая езда.'
#    votes: 0
#    juri: 24
#
#  Girls.insert
#    name: 'Мария'
#    surname: 'Иевлева'
#    pic: 'images/ivleva.jpg'
#    video: "https://www.youtube.com/embed/UzcRHekc-5o"
#    thumb: 'bakirova.png'
#    text: ' Камера. Мотор. Начали. Проект кинопробы был занимательным для меня. Оказаться в мире кино очень приятно. Сложная аппаратура, «голливудская» камера, поток тёплого света и добрые люди, которые любят свою работу. Удовольствие. Сказка. И я благодарю за это прекрасное приключение.'
#    votes: 0
#    juri: 27
#
#  Girls.insert
#    name: 'Наталья'
#    surname: 'Чоха'
#    pic: 'images/choha.jpg'
#    video: "https://www.youtube.com/embed/ZaVwqTM1phs"
#    thumb: 'shnaider.png'
#    text: '"Я не намерен портить отношений ни с небесами, ни с адом, - у меня есть друзья и в той, и в другой местности". Марк Твен \n Эта цитата максимально точно отражает мое понимание дуализма женской «идеальности». Жизнь показывает, что быть для всех ангелом невозможно и наоборот. Я привыкла предъявлять к себе и всему, что делаю высокие требования, потому постоянно нахожусь в процессе раскрытия потенциала и реализации возможностей. Люблю сложности и новое. Участие в профессиональных съемках было для меня неожиданным и приятным опытом, который помог мне увидеть себя с новой стороны.'
#    votes: 0
#    juri: 43

#Meteor.startup ->
#
#  Girls.update {surname: 'Селиверстова'}, {$set: {votes: 758}}
#  Girls.update {surname: 'Сокольникова'}, {$set: {votes: 623}}
#  Girls.update {surname: 'Газа'}, {$set: {votes: 801}}
#  Girls.update {surname: 'Бакирова'}, {$set: {votes: 654}}
#  Girls.update {surname: 'Иевлева'}, {$set: {votes: 728}}
#  Girls.update {surname: 'Шнайдер'}, {$set: {votes: 651}}
#  Girls.update {surname: 'Александрова'}, {$set: {votes: 540}}