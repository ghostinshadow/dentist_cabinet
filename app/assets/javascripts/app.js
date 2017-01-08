var myClinic = angular.module('myClinic', ['ngResource', 'ngRoute',
    'simplePagination', 'ngAnimate', 'ngTouch', "ngFlash"
]);

myClinic.config(["$routeProvider",
    function($routeProvider) {
        $routeProvider.
        when("/home", {
            templateUrl: "assets/main.html",
            controller: "MainController"
        }).
        when("/createForm", {
            templateUrl: "assets/formCreate.html",
            controller: "FormController"
        }).
        when("/photoGallery", {
            templateUrl: "assets/photoGallery.html",
            controller: "FormController"
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

myClinic.config((FlashProvider) => {
    FlashProvider.setTimeout(5000);
    FlashProvider.setShowClose(true);
});