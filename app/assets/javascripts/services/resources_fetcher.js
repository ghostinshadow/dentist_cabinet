angular.module('myClinic')

    .factory('UserService', function ($http) {
        var service = {};

        service.get_patients_by_character = get_patients;
        service.post_patient_info = post_patient;
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
            }, handle_error("Shift!"));
        }

        function get_patients(char, callback) {
            awesome_request = params_constructor('/patients', {char: char});
            return $http(awesome_request).then(function (response) {
                callback(response);
            }, handle_error);
        };


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
            // console.log(response);
            if ((response.status === 403) || (response.status === 401)){
                $state.go('login',{status: 401});
            };
        };

    });