var myClinic = angular.module("myClinic");

myClinic.controller("FormController", function($scope, UserService, Flash) {

    $scope.submitForm = function(patient) {
        patient = patient || {}
        UserService.post_patient_info({
            patient: patient
        }, function(response) {
            if (response.data["errors"]) {
                $scope.parseErrorsFromResponse(response);
                Flash.create('info', "Дані не вдалось надіслати")
            } else {
                $scope.goHomeWithUser(response.data);
                $scope.refreshAppointList(response.data);
                Flash.create('success',"Запис успішно додано")
            }
        })
    };

    $scope.updateForm = function(patient) {
        UserService.update_patient(patient, function(response){
            if (response.data["errors"]) {
                $scope.parseErrorsFromResponse(response);
                Flash.create('info', "Дані не вдалось оновити")
            } else {
                $scope.goHomeWithUser(response.data);
                Flash.create('success',"Запис успішно оновлено")
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