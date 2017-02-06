var myClinic = angular.module('myClinic', ['ngResource', 'ngRoute',
    'simplePagination', 'ngAnimate', 'ngTouch', "ngFlash",
     'angularModalService', 'angularFileUpload'
]);

myClinic.config(["$routeProvider",
    function($routeProvider) {
        $routeProvider.
        when("/home", {
            templateUrl: "assets/main.html",
            controller: "DictionariesController"
        }).
        when("/createForm", {
            templateUrl: "assets/patientForm.html",
            controller: "FormController"
        }).
        when("/photoGallery", {
            templateUrl: "assets/photoGallery.html",
            controller: "galleryController"
        }).
        otherwise({
            redirectTo: "/home"
        });
    }
]);

myClinic.filter('reverse', function() {
    return function(items) {
        if (items) {
            return items.slice().reverse();
        }
    };
});

myClinic.config(function(FlashProvider) {
    FlashProvider.setTimeout(5000);
    FlashProvider.setShowClose(true);
});