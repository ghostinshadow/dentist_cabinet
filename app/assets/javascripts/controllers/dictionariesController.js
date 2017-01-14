// var myClinic = angular.module("myClinic");
// var fs = require('fs');
// var db = require('diskdb');
// var gui = require('nw.gui');
// var win = gui.Window.get();
// var SHA3 = require("crypto-js/sha3");
// var encryptor = require('file-encryptor');
// var options = {
//     algorithm: 'aes256'
// };

// var util = require('util');
// var log_file = fs.createWriteStream('log/debug.log', {flags : 'a'});

// console.log = function(d) { 
//   var date =  new Date()
//   log_file.write('=================' + '\n' + date + '\n' + util.format(d) + '\n' + '=================');
// };

// win.on('maximize', function() {
//     win.isMaximized = true;
// });

// win.on('unmaximize', function() {
//     win.isMaximized = false;
// });

myClinic.controller("DictionariesController",

    function($scope, UserService, Flash) {

        $scope.alphabet = ['А', 'Б', 'В', 'Г', 'Д', 'Е', 'Є',
            'Ж', 'З', 'І', 'Ї', 'Й', 'К', 'Л',
            'М', 'Н', 'О', 'П', 'Р', 'С', 'Т',
            'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ',
            'Ю', 'Я'
        ];


        $scope.ortodoncy = ["Огляд - консультація",
            "Діагностичні моделі",
            "Функціональна діагностика",
            "Постановка лігатурних брекетів в/щ",
            "Постановка лігатурних брекетів н/щ",
            "Постановка безлігатурних брекетів в/щ",
            "Постановка безлігатурних брекетів н/щ",
            "Постановка керамічних брекетів в/щ",
            "Постановка керамічних брекетів н/щ",
            "Пластинка в/щ",
            "Пластинка н/щ",
            "Піднебінний розширювач Хейрікс",
            "Дисталізуючий апарат на в/щ Хейрікс",
            "Піднебінний розширювач Хейрікс на кані.",
            "Маска одноосьова",
            "Апарат на н/щ Flexdevelop",
            "Ретенційний апарат",
            "Прозорий ретейнер  на одну щелепу",
            "Ремонт апаратів",
            "Фотографії",
            "Зняття брекетів в/щ",
            "Зняття брекетів н/щ"
        ];

        $scope.theraphy = ["Профілактичний огляд постійних пацієнтів",
            "Консультація та огляд лікаря",
            "Професійна гігієна порожнини рота",
            "Зняття відкладень з одного зуба",
            "Герметизація фісур",
            "Герметизація премолярів",
            "Герметизація молярів",
            "Анестезія",
            "Кофердам",
            "Rvg",
            "Фотополімерна пломба",
            "Шклоіономерна пломба",
            "Реставрація 1/3",
            "Реставрація 1/2",
            "Реставрація 2/3",
            "Реставрація повна",
            "Анкерування",
            "Пломбування каналу 1",
            "Пломбування каналу 2",
            "Пломбування каналу 3",
            "Розпломбовування каналу 1",
            "Розпломбовування каналу 2",
            "Розпломбовування каналу 3",
            "Лікувальна пов'язка(крезофен)",
            "Лікувальна пов'язка(девітпаста)",
            "Лікувальна пов'язка(calasept)",
            "Лікувальна пов'язка(proroot)",
            "Лікувальна пов'язка(resodonte)",
            "Тимчасова пломба",
            "Видалення анкера",
            "Цементування коронок",
            "Невідкладна допомога",
            "Видалення молочного зуба",
            "Глибоке фторування зубів",
            "Зняття коронок",
            "Видалення молочного зуба"
        ];

        $scope.teeth = [ "11", "12", "13", "14", "15", "16",
            "17", "18", "21", "22", "23", "24", "25", "26",
            "27", "28", "31", "32", "33", "34", "35",
            "36", "37", "38", "41", "42", "43", "44",
            "45", "46", "47", "48", "51", "52", "53", "54",
            "55", "61", "62", "63", "64", "65", "71", "72",
            "73", "74", "75", "81", "82", "83", "84", "85"
        ];
    }
);
