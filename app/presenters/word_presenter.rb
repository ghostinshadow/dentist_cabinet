class WordPresenter < BasePresenter
  presents :word

  def initialize(word, template, *helper_objects)
    super
    @dictionary = helper_objects.first
  end

  def render_form
    h.form_for word, url: form_url_based_on_persistance do |f|
      display_errors
      yield f
    end
  end

  def link_to_dictionary
  	h.link_to 'Назад', h.dictionary_words_path(@dictionary), class: 'btn btn-danger'
  end

  private

  def form_url_based_on_persistance
    return h.dictionary_words_path(@dictionary, dictionary_id: @dictionary.id) if word.new_record?
    h.word_path(word, dictionary_id: @dictionary.id)
  end

  def display_errors
    return if word.errors.empty?
    h.haml_tag :div, id: "error_explanation" do
      h.haml_tag :h2 do
        "#{pluralize(word.errors.count, "error")} prohibited this word from being saved:"
      end
      h.haml_tag :ul do
        word.errors.full_messages.each do |msg|
          h.haml_tag(:li) { msg }
        end
      end
    end
  end

end
