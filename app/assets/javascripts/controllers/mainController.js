var myClinic = angular.module("myClinic");

myClinic.controller("MainController", function($scope, $location, $timeout, Pagination, UserService, Flash, ModalService) {
    UserService.get_patient_creation_dictionaries(function(response){
        $scope.doctors = response.data.doctors;
        $scope.towns = response.data.cities;
    })

    UserService.get_work_creation_dictionaries(function(response){
        $scope.work_specific_dictionaries = response.data.dictionary;
        $scope.dictionaries_info = response.data.info;
        $scope.dictionaries_names = [];
        angular.forEach($scope.dictionaries_info, function(element, value){
            $scope.dictionaries_names.push(element);
        });
    })

    $scope.showModal = function() {
        $scope.hideWorkForm();
        ModalService.showModal({
            templateUrl: "assets/modalForm.html",
            controller: "ModalController",
            inputs: {
                patient: this.selectedPatient,
            }
        }).then(function(modal) {
            modal.element.modal();
            modal.close.then(function(result) {
                if (result.creation_time) {
                    $scope.appointments.unshift(result)
                    $scope.paginationManage();
                    $scope.selectAppointment(result);
                }
                $scope.resetModal();
            });
        });

    };

    $scope.resetModal = function(){
        $('.modal-backdrop').remove()
    }

    $scope.go = function(path, clear) {
        $location.path(path);
        console.log(path);
        if (clear) {
            $scope.clearTemp();
        }
    };

    $scope.triggerWorkForm = function(appointment) {
        $scope.selectedAppointment = appointment;
        $scope.workForm = !$scope.workForm;
    };

    $scope.selectedTooth;
    $scope.selectedChar;
    $scope.selectedPatient;
    $scope.selectedAppointment;
    $scope.patientToUpdate;
    $scope.dataAtr;
    $scope.workForm = false;
    $scope.toothInfo = true;
    $scope.pagination = Pagination.getNew(6);

    $scope.toggleSelected = function(teeth, tooth_num){
        if(!$scope.isIncudedInCollection(teeth, tooth_num)){
            teeth.push(tooth_num);
        }else{
            teeth.splice(teeth.indexOf(tooth_num), 1);
        }
    };

    $scope.isIncudedInCollection = function(collection, el){
        return (collection.indexOf(el) < 0) ? false : true
    }

    $scope.addWork = function(work) {
        this.replace_placeholders(work);
        UserService.post_appointments_performed_work(this.selectedAppointment.id, work, function(response) {
            if (response.data["error"]) {
                Flash.create('info', "Дані не вдалось зберегти")
            } else {
                Flash.create('success', "Запис успішно створено")
            }
        })
        $timeout(function() {
            $scope.triggerWorkForm($scope.selectedAppointment);
            $scope.selectAppointment($scope.selectedAppointment);
        }, 1, true);
    }

    $scope.replace_placeholders = function(work) {
        teeth_dictionary = {
            up_teeth_nums: this.up_teeth_nums,
            bottom_teeth_nums: this.bottom_teeth_nums,
            up_milk_nums: this.up_milk_nums,
            bottom_milk_nums: this.bottom_milk_nums
        };
        var accumulate_replaced = work.teeth_nums.reduce(function(accumulator, el){
            Number.isInteger(el) ? accumulator.push([el]) : accumulator.push(teeth_dictionary[el]);
            return accumulator;
        },[]);
        work.teeth_nums = accumulate_replaced.reduce(function(a, b) { return a.concat(b);})
    }

    $scope.goHome = function(client) {
        $scope.go('/main');
    };

    $scope.isEmpty = function() {
        if ($scope.clients.length === 0) {
            return true;
        }
        return false;
    };

    $scope.isSelected = function(char) {
        if ($scope.selectedChar) {
            return $scope.selectedChar === char;
        }
    };

    $scope.isSelectedTooth = function(num) {
        if ($scope.selectedTooth) {
            return $scope.selectedTooth === num;
        }
    };

    $scope.isSelectedPatient = function(client) {
        if ($scope.selectedPatient) {
            return $scope.selectedPatient === client;
        }
    };

    $scope.clearTemp = function() {
        $scope.newClient = null;
        $scope.patientToUpdate = null;
        $scope.query = null;
    };

    $scope.selectAppointment = function(appoint) {
        $scope.worksDone = null;
        $scope.toothInfo = true;
        $scope.selectedTooth = null;
        $scope.selectedAppointment = appoint;
        UserService.load_completed_work(appoint, function(response){
            $scope.worksDone = response.data;
            $scope.findHealedTeeth($scope.worksDone);
        })
    };

    $scope.findAllHealedTeeth = function(arr) {
        var result = result || [];
        angular.forEach(arr, function(elm) {
            $scope.iterateOverArray(elm.worksDone, result);
        })
        $timeout(function() {
            $scope.healedTeeth = result;
        }, 0, true);
    }

    $scope.isBeenHealed = function(elm) {
        if (elm && $scope.healedTeeth) {
            return ($scope.healedTeeth.indexOf(elm.toString()) == -1) ? false : true;
        }
    };

    $scope.findWorkOnTooth = function(num) {
        UserService.load_works_for_tooth($scope.selectedPatient.id, num, function(response){
           $scope.toothInfo = false;
           $scope.selectedTooth = num;
           $scope.toothInfoList = response.data;
        })
    };

    $scope.iterateOverArray = function(arr, result) {
        angular.forEach(arr, function(elm) {
            var arr_len = elm.teeth_nums.length,
                i = 0;
            if (arr_len > 1) {
                for (i; i < arr_len; i++) {
                    result.push(elm.teeth_nums[i]);
                }
            } else {
                result.push(elm.teeth_nums[0]);
            }
        })
        return result;
    }

    $scope.findHealedTeeth = function(arr) {
        var result = result || [];
        $scope.iterateOverArray(arr, result);
        $timeout(function() {
            $scope.healedTeeth = result;
        }, 0, true);
    };

    $scope.paginationManage = function() {
        $scope.pagination.numPages = Math.ceil($scope.appointments.length / $scope.pagination.perPage);
    };

    $scope.selectPatient = function(client) {
        $scope.selectedTooth = null;
        $scope.selectedAppointment = null;
        $scope.hideWorkForm();
        $scope.healedTeeth = [];
        $scope.toothInfo = true;
        $scope.selectedPatient = client;
        UserService.load_appointments(client, function(response){
          $scope.appointments = response.data;
          $scope.paginationManage();
          $scope.findAllHealedTeeth(client.appointments);
        })
    };

    $scope.hideWorkForm = function(){
        $scope.workForm = false;
    }

    $scope.filterDictionaryByKey = function(collection, key, element){
        element = element || $scope.selectedPatient;
        var filtered = collection.filter(function(word){
            return word.id == (element[key]);
        });
        return filtered[0];
    }

    $scope.initUpdate = function(patient) {
        $scope.go('/createForm')
        $scope.patientToUpdate = true;
        patient.birth_day = new Date(patient.birth_day);
        $scope.newClient = patient;
    };

    $scope.displayBirthday = function(birth_day){
        return (birth_day instanceof Date) ? birth_day.toISOString().substring(0, 10) : birth_day;
    }

    $scope.updateForm = function(patient) {
        UserService.update_patient(patient, function(response){
            if (response.data["errors"]) {
                $scope.parseErrorsFromResponse(response);
                Flash.create('info', "Дані не вдалось оновити")
            } else {
                $scope.goHome(response.data);
                patient.birth_day = response.data.birth_day;
                Flash.create('success',"Запис успішно оновлено")
            }
        })

    };

    $scope.deleteAppoint = function(appoint, client) {
        if (confirm("Ви впевнені, що хочете видалити цей прийом?")) {
            UserService.delete_appointment(appoint, function(response){
                Flash.create('success',"Запис успішно видалено");
                var index = $scope.appointments.indexOf(appoint);
                $scope.appointments.splice(index, 1);
                $scope.selectedAppointment = null;
                $scope.paginationManage();
            });
        }
    };

    $scope.deleteWork = function(work) {
        if (confirm("Ви впевнені, що хочете видалити запис про виконану роботу?")) {
            UserService.delete_performed_work(work, function(response) {
                Flash.create('success', "Запис успішно видалено");
            });
            $timeout(function() {
                $scope.selectAppointment($scope.selectedAppointment);
                $scope.paginationManage();
            }, 1, true)
        }
    };

    $scope.deletePatient = function(patient) {
        if (confirm("Ви впевнені, що хочете видалити цей запис?")) {
            UserService.delete_patient(patient, function(response) {
                Flash.create('success', "Запис успішно видалено")
                $scope.findInDatabase(patient.last_name[0]);
                $scope.selectedPatient = null;
            })
        }
    };

    $scope.isSelectedAppointment = function(appoint) {
        if ($scope.selectedAppointment) {
            return $scope.selectedAppointment === appoint;
        }
    };


    $scope.refreshAppointList = function(patient) {
        $timeout(function() {
            $scope.findInDatabase(patient.last_name[0], false);
            $scope.selectPatient(patient);
        }, 0, true);
    };

    $scope.findInDatabase = function(char, refresh) {
        $scope.hideWorkForm();
        UserService.get_patients_by_character(char, function(response) {
            $scope.clients = response.data;
            $scope.selectedChar = char;
            if (refresh) {
                $scope.selectedPatient = null;
            }
        });
    };

    $scope.localize = {
        Jan: '01',
        Feb: '02',
        Mar: '03',
        Apr: '04',
        May: '05',
        Jun: '06',
        Jul: '07',
        Aug: '08',
        Sep: '09',
        Oct: '10',
        Nov: '11',
        Dec: '12'
    }

    $scope.localize_month = {
        '01': 'Січня' ,
        '02': 'Лютого',
        '03': 'Березня',
        '04': 'Квітня',
        '05': 'Травня',
        '06': 'Червня',
        '07': 'Липня',
        '08': 'Серпня',
        '09': 'Вересня',
        '10': 'Жовтня',
        '11': 'Листопада',
        '12': 'Грудня'
    }

    $scope.up_teeth_nums = [18,17,16,15,14,13,12,11,21,22,23,24,25,26,27,28];

    $scope.bottom_teeth_nums = [48,47,46,45,44,43,42,41,31,32,33,34,35,36,37,38];

    $scope.up_milk_nums = [55,54,53,52,51,61,62,63,64,65];

    $scope.bottom_milk_nums = [85,84,83,82,81,71,72,73,74,75];

});