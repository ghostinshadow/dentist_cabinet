class PatientsController < ApplicationController
  respond_to :json
  # add cancan

  def index
    # Patient.with_user(current_user.id)
    @patients = Patient.all.with_user(current_user.id).filter_first_char(params[:char])
    render json: @patients
  end

  def create
    @patient = current_user.patients.create(patient_params)
    if @patient.new_record?
      render json: { errors: @patient.errors}
    else
      render json: @patient
    end
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
      render json: @patient
    else
      render json: {errors: @patient.errors}
    end

  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
  end

  private

  def patient_params
    return {} if params[:patient].blank?
    params.require(:patient).permit(:last_name, :first_name, :user_id,
                                    :doctor_id, :milk_teeth, :birth_day,
                                    :town_id, :telephone, :email, :backup_telephone)
  end
end
