class DictionariesController < ApplicationController
  before_action :set_dictionary, only: [:show, :edit, :update, :destroy]
  respond_to :json, only: [:doctors_and_cities]

  # GET /dictionaries
  # GET /dictionaries.json
  def index
    @dictionaries = Dictionary.all
  end

  # GET /dictionaries/1
  # GET /dictionaries/1.json
  def show
  end

  # GET /dictionaries/new
  def new
    @dictionary = Dictionary.new
  end

  # GET /dictionaries/1/edit
  def edit
  end

  # POST /dictionaries
  # POST /dictionaries.json
  def create
    @dictionary = Dictionary.new(dictionary_params)

    respond_to do |format|
      if @dictionary.save
        format.html { redirect_to @dictionary, notice: 'Dictionary was successfully created.' }
        format.json { render :show, status: :created, location: @dictionary }
      else
        format.html { render :new }
        format.json { render json: @dictionary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dictionaries/1
  # PATCH/PUT /dictionaries/1.json
  def update
    respond_to do |format|
      if @dictionary.update(dictionary_params)
        format.html { redirect_to @dictionary, notice: 'Dictionary was successfully updated.' }
        format.json { render :show, status: :ok, location: @dictionary }
      else
        format.html { render :edit }
        format.json { render json: @dictionary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dictionaries/1
  # DELETE /dictionaries/1.json
  def destroy
    @dictionary.destroy
    respond_to do |format|
      format.html { redirect_to dictionaries_url, notice: 'Dictionary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def doctors_and_cities
    doctor_dict, cities_dict = current_user.dictionaries.where(resource_type: ["Doctors", "Cities"])
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def dictionary_params
    params.require(:dictionary).permit(:user_id, :title, :resource_type)
  end
end
