# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.all.each(&:destroy)
u = User.create(email: 'kichun.olena@gmail.com', password: "mari11111")

therapy, ortodoncy, doctors, cities = u.dictionaries.includes(:words)
f = File.open("#{Rails.root.to_s}/lib/clients.json", "r")
json_data_representation = JSON.parse(f.read)

json_data_representation.each do |patient|
  doctor_word = doctors.words.select{|e| e.body == patient["doctor"]}.first

  town_word = cities.words.select{|e| e.body == patient["town"]}.first
  binding.pry unless town_word
  created_patient = u.patients.create(last_name: patient["surname"],
                    first_name: patient["name"],
                    milk_teeth: (patient["milkTeeth"] == "Є") ? true : false,
                    birth_day: Date.parse(patient["birthDay"]),
                    telephone: patient["telNumber1"],
                    backup_telephone: patient["telNumber2"],
                    email: patient['email'],
                    doctor_id: doctor_word.id,
                    town_id: town_word.id)
  patient["appointments"].each do |appoint|
  	month, day, year = appoint["creationTime"].split("\s")
    created_appointment = created_patient.appointments.create(
      creation_time: Date.new(year.to_i, month.to_i, day.to_i)
    )

    appoint["worksDone"].each do |w_done|
      exact_dict = w_done["workType"] == "Терапія" ? therapy : ortodoncy
      word_work = exact_dict.words.select{|w| w.body == w_done["exactWork"]}.first
      
      created_appointment.performed_works.create(
        price: w_done["price"],
        word_id: word_work.id,
        dictionary_id: word_work.dictionary_id,
        teeth_nums: w_done["teeth_nums"]
        )
    end

  end
end