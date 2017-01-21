var myClinic = angular.module("myClinic");

myClinic.controller("galleryController", function($scope, $interpolate,
 $timeout, $location, UserService, Flash, FileUploader) {
 	  var csrf_token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    $scope.uploader = new FileUploader({
        headers: {
            'X-CSRF-TOKEN': csrf_token // X-CSRF-TOKEN is used for Ruby on Rails Tokens
        },
        url: "/patients/" + $scope.selectedPatient.id + "/patient_pictures"
    });

    $scope.uploader.onCompleteAll = function() {
    	Flash.create("info", "Картинку збережено")
        $scope.fetch_pictures();
    };

    $scope._Index = 0;
    $scope.photos = [];

    $scope.fetch_pictures = function() {
        UserService.get_pictures($scope.selectedPatient.id, function(response) {
        	  debugger;
            $scope.photos = response.data;
        })
    }


    $scope.isActive = function(index) {
        return $scope._Index === index;
    };

    $scope.showPrev = function() {
        $scope._Index = ($scope._Index > 0) ? --$scope._Index : $scope.photos.length - 1;
    };

    $scope.showNext = function() {
        $scope._Index = ($scope._Index < $scope.photos.length - 1) ? ++$scope._Index : 0;
    };

    $scope.showPhoto = function(index) {
        $scope._Index = index;
    };


    $scope.filesChanged = function(elm) {
        var count, len = elm.files.length;
        ((elm.files.length > 1)) ? count = len: count = 1;
        $timeout(function() {
            $scope.files = elm.files;
            if (len > 0) {
                $scope.count = count + ' файл(и) обрано';
            }
        })

    };

    $scope.photosRead = function() {

    };

    $scope.photosRead();

    $scope.writeFile = function(name, path, data) {
        fs.writeFile(path + '/' + name,
            data,
            function(err) {
                if (err) throw err;
            }
        )

    }

    $scope.upload = function() {
       this.uploader.uploadAll();
    };
    $scope.fetch_pictures();
		$(":file").filestyle({input: false, buttonText: "Оберіть файл"});
})