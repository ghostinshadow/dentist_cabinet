class DictionariesController < ApplicationController
  before_action :set_dictionary, only: [:show, :edit, :update, :destroy]
  respond_to :json, only: [:doctors_and_cities]

  # GET /dictionaries
  # GET /dictionaries.json
  def index
    @dictionaries = current_user.dictionaries
  end

  # GET /dictionaries/1
  # GET /dictionaries/1.json
  def show
  end

  # POST /dictionaries
  # POST /dictionaries.json

  def doctors_and_cities
    cities_dict, doctor_dict = current_user.dictionaries.where(resource_type: ["Doctors", "Cities"])
    render json: {doctors: doctor_dict.words.select(:id, :body),
                  cities: cities_dict.words.select(:id, :body)}
  end

  def work_specific_dictionaries
    render json: current_user.dictionaries.form_information_about_work_specific_dictionaries
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_dictionary
    @dictionary = Dictionary.find(params[:id])
  end

end
