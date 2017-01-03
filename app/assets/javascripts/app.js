var myClinic = angular.module('myClinic', ['ngResource', 'ngRoute', 'simplePagination','ngAnimate', 'ngTouch']);

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
    return items.slice().reverse();
  };
});