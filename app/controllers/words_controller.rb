class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :set_dictionary

  def index
    @words = @dictionary.words
  end

  def new
    @word = Word.new
  end

  def edit
  end

  def create
    @word = @dictionary.words.new(word_params)

    if @word.save
      redirect_to dictionary_words_path(@dictionary), notice: 'Слово було сторено.'
    else
      render :new
    end
  end

  def update
    if @word.update(word_params)
      redirect_to dictionary_words_path(@dictionary), notice: 'Слово було оновлено.'
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    redirect_to dictionary_words_path(@dictionary), notice: 'Слово було видалено.'
  end

  private

  def set_dictionary
    @dictionary = Dictionary.find(params[:dictionary_id])
  end

  def set_word
    @word = Word.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:user_id, :body, :resource_type)
  end
end
