var myClinic = angular.module("myClinic");

myClinic.controller("ModalController", function($scope, close, patient, $timeout, UserService, Flash) {
    $scope.closeModal = function() {
        close("Yes", 200); // close, but give 200ms for bootstrap to animate
    };

    $scope.createAppointment = function(appoint) {
        UserService.post_appointment(patient.id, appoint, function(response) {
            if (response.data.errors) {
                Flash.create('error', "Дані не вдалось зберегти");
            } else {
                Flash.create('success', "Запис успішно створено");
            }
            close(response.data)
        })
    };
})