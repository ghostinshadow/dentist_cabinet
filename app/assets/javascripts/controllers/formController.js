var myClinic = angular.module("myClinic");

myClinic.controller("FormController", function($scope, $interpolate, $timeout, $location, UserService, Flash) {

    $scope.folderName = $interpolate('img/{{surname}}_{{name}}');

    $scope._Index = 0;


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
        fs.readdir($scope.selectedPatient.folderName, function(err, files) {
            if (err) throw err;
            $timeout(function() {
                $scope.photos = files;
            }, 0, true);
        })
    };


    if ($location.path() === '/photoGallery') {
        $scope.photosRead();
    };

    $scope.writeFile = function(name, path, data) {
        fs.writeFile(path + '/' + name,
            data,
            function(err) {
                if (err) throw err;
            }
        )

    }

    $scope.upload = function() {
        var new_files = $scope.files,
            patient = $scope.selectedPatient,
            temp;
        angular.forEach(new_files, function(file) {
            fs.readFile(file.path, function(err, data) {
                if (err) throw err;
                $scope.writeFile(file.name, patient.folderName, data);
            })
        })
        $timeout(function() {
            $scope.photosRead();
            $scope.files = [];
            $scope.count = '';
        }, 500, true);
    };

    $scope.submitForm = function(patient) {
        patient = patient || {}
        UserService.post_patient_info({
            patient: patient
        }, function(response) {
            if (response.data["errors"]) {
                $scope.parseErrorsFromResponse(response);
                Flash.create('info', "Дані не вдалось надіслати")
            } else {
                $scope.goHomeAndSelect(patient, true);
                Flash.create('success',"Запис успішно додано")
            }
        })
    };

    $scope.parseErrorsFromResponse = function(response) {
        angular.forEach(response.data["errors"], function(message, key) {
            $scope.form[key].$dirty = true
        })
    }

    $scope.fetchValuesForDropdowns = function(){
        UserService.get_patient_creation_dictionaries(function(response){
            $scope.doctors = response.data.doctors;
            $scope.towns = response.data.cities;
        })
    }

    $scope.fetchValuesForDropdowns();
})
.directive('convertToNumber', function() {
  return {
    require: 'ngModel',
    link: function(scope, element, attrs, ngModel) {
      ngModel.$parsers.push(function(val) {
        return parseInt(val, 10);
      });
      ngModel.$formatters.push(function(val) {
        return '' + val;
      });
    }
  };
});