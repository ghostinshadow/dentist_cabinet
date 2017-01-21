angular.module('myClinic')

    .factory('UserService', function ($http, Flash) {
        var service = {};

        service.get_patients_by_character = get_patients;
        service.post_patient_info = post_patient;
        service.get_patient_creation_dictionaries = get_doctors_and_cities_info;
        service.get_work_creation_dictionaries = get_theraphy_and_orthodoncy_info;
        service.update_patient = put_patient_info;
        service.delete_patient = delete_patient;
        service.delete_appointment = delete_appointment;
        service.delete_performed_work = delete_performed_work;
        service.load_appointments = load_appointments;
        service.load_completed_work = load_completed_work;
        service.load_works_for_tooth = load_works_performed_on_tooth;
        service.post_appointments_performed_work = post_appointments_performed_work;
        service.post_appointment = post_appointment;
        service.get_pictures = get_pictures_urls;

        return service;

        function params_constructor(url, additional_params, method){
            method = method || "GET";
            return {
                method: method,
                url: "http://localhost:3000" + url + '.json',

                params: additional_params
            };
        }

        function post_request_constructor(url, data, method){
            method = method || "POST";
            return {
                method: method,
                url: "http://localhost:3000" + url,
                dataType: 'json',
                data: data,
                headers: {
                    "Content-Type": "application/json"
                }
            };
        }

        function post_patient(patient, callback) {
            post_request = post_request_constructor('/patients', patient)
            return $http(post_request).then(function (response) {
                callback(response);
            }, handle_error);
        }

        function put_patient_info(patient, callback){
            post_request = post_request_constructor("/patients/" + patient.id, patient, "PUT")
            return $http(post_request).then(function(response){
                callback(response);
            }, handle_error);
        }

        function get_patients(char, callback) {
            awesome_request = params_constructor('/patients', {char: char});
            return $http(awesome_request).then(function (response) {
                callback(response);
            }, handle_error);
        };

        function get_doctors_and_cities_info(callback){
            get_request = params_constructor("/dictionaries/doctors_and_cities")
            return $http(get_request).then(function(response){ callback(response)}, handle_error)
        };

        function get_theraphy_and_orthodoncy_info(callback){
            get_request = params_constructor("/dictionaries/work_specific_dictionaries")
            return $http(get_request).then(function(response){ callback(response)}, handle_error)
        }

        function delete_patient(patient, callback){
            delete_request = post_request_constructor("/patients/" + patient.id, {id: patient.id}, "DELETE");
            return $http(delete_request).then(function(response){ callback(response)}, handle_error)
        }

        function delete_appointment(appointment, callback){
            delete_request = post_request_constructor("/appointments/" + appointment.id, {id: appointment.id}, "DELETE");
            return $http(delete_request).then(function(response){ callback(response)}, handle_error)
        }

        function delete_performed_work(performed_work, callback){
            delete_request = post_request_constructor("/performed_works/" + performed_work.id,
                                                       {id: performed_work.id}, "DELETE");
            return $http(delete_request).then(function(response){ callback(response)}, handle_error)
        }

        function load_appointments(patient, callback){
            get_request = params_constructor("/patients/" + patient.id + "/appointments")
            return $http(get_request).then(function(response){ callback(response)}, handle_error);
        }

        function load_completed_work(appointment, callback){
            get_request = params_constructor("/appointments/" + appointment.id + "/performed_works");
            return $http(get_request).then(function(response){callback(response)}, handle_error);
        }

        function load_works_performed_on_tooth(patient_id, tooth_num, callback){
            get_request = params_constructor("/works_performed_on_tooth", {patient_id: patient_id, num: tooth_num});
            return $http(get_request).then(function(response){callback(response), handle_error});
        }

        function post_appointments_performed_work(appointment_id, performed_work, callback){
            post_request = post_request_constructor("/appointments/" + appointment_id + "/performed_works", performed_work);
            return $http(post_request).then(function (response) {
                callback(response);
            }, handle_error);
        }

        function post_appointment(patient_id, appointment, callback){
            post_request = post_request_constructor("/patients/"+ patient_id + "/appointments", appointment);
            return $http(post_request).then(function(response){
                callback(response);
            }, handle_error);
        }

        function get_pictures_urls(patient_id, callback){
            get_request = params_constructor("/patients/"+ patient_id + "/patient_pictures");
            return $http(get_request).then(function(response){
                callback(response);
            }, handle_error);
        }

        function merge(one, two) {
            for (var p in two) {
                try {
                    if (two[p].constructor == Object) {
                        one[p] = MergeRecursive(one[p], two[p]);

                    } else {
                        one[p] = two[p];
                    }
                } catch (e) {
                    one[p] = two[p];
                }
            }
            return one;
        };

        function handle_success(response) {
            return response;
        };

        function handle_error(response) {
            Flash.create("danger", "Не вдалось з'єднатись з сервером");
        };

    });