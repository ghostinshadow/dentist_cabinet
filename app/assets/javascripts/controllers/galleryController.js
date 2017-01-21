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

    $scope._Index1 = 0;
    $scope._Index2 = 0;
    $scope.photos = [];

    $scope.fetch_pictures = function() {
        UserService.get_pictures($scope.selectedPatient.id, function(response) {
            $scope.photos = response.data;
        })
    }

    $scope.deletePicture = function(container_number){
			var element_for_deletion = null;
			if(container_number == 1){
				element_for_deletion = this.photos[this._Index1]
			}else{
				element_for_deletion = this.photos[this._Index2]
			}
			UserService.delete_picture(element_for_deletion.id, function(response){
        if (response.data["error"]) {
            Flash.create('info', "Дані не вдалось видалити")
        } else {
            Flash.create('success', "Картинку видалено")
        }
        $scope.fetch_pictures();
			})

    }


    $scope.isActive1 = function(index) {
        return $scope._Index1 === index;
    };

    $scope.showPrev1 = function() {
        $scope._Index1 = ($scope._Index1 > 0) ? --$scope._Index1 : $scope.photos.length - 1;
    };

    $scope.showNext1 = function() {
        $scope._Index1 = ($scope._Index1 < $scope.photos.length - 1) ? ++$scope._Index1 : 0;
    };

    $scope.showPhoto1 = function(index) {
        $scope._Index1 = index;
    };

    $scope.isActive2 = function(index) {
        return $scope._Index2 === index;
    };

    $scope.showPrev2 = function() {
        $scope._Index2 = ($scope._Index2 > 0) ? --$scope._Index2 : $scope.photos.length - 1;
    };

    $scope.showNext2 = function() {
        $scope._Index2 = ($scope._Index2 < $scope.photos.length - 1) ? ++$scope._Index2 : 0;
    };

    $scope.showPhoto2 = function(index) {
        $scope._Index2 = index;
    };

    $scope.upload = function() {
       this.uploader.uploadAll();
    };
    $scope.fetch_pictures();
		$(":file").filestyle({input: false, buttonText: "Оберіть файл"});
})