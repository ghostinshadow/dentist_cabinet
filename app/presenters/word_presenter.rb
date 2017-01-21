class WordPresenter < BasePresenter
  presents :word
  delegate :body, to: :word

  def initialize(word, template, *helper_objects)
    super
    @dictionary = helper_objects.first
  end

  def render_form
    h.form_for word, url: form_url_based_on_persistance do |f|
      display_errors
      h.haml_tag :div, class: 'form-group' do
        h.haml_concat(f.label('Слово'))
        h.haml_concat(f.text_field( :body, class: 'form-control'))
      end
      h.haml_tag :div, class: "actions form-actions" do
        h.haml_concat(f.submit('Зберегти', class: 'btn btn-success pull-right'))
        h.haml_concat link_to_dictionary
      end
    end
  end

  def table_row
    h.haml_tag :tr do
      h.haml_tag(:td){ h.haml_concat(body)}
      h.haml_tag :td do
        h.haml_concat(link_to_edit)
      end
      h.haml_tag :td do
        h.haml_concat(link_to_delete)
      end
    end
  end

  private

  def link_to_dictionary
    h.link_to 'Назад', h.dictionary_words_path(@dictionary), class: 'btn btn-danger'
  end

  def link_to_edit
  	h.link_to 'Змінити', h.edit_word_path(word, dictionary_id: @dictionary.id)
  end

  def link_to_delete
  	h.link_to 'Видалити', h.word_path(word, dictionary_id: @dictionary.id),
          :method => :delete, :data => { :confirm => 'Are you sure?' }
  end

  def display_errors
    return if word.errors.empty?
    h.haml_tag :div, nil, id: "error_explanation" do
      h.haml_tag :h2 do
        h.haml_concat "#{h.pluralize(word.errors.count, "error")} завадили збереженню:"
      end
      h.haml_tag :ul do
        word.errors.messages.each do |key, msgs|
          h.haml_tag(:li) { h.haml_concat msgs.first }
        end
      end
    end
  end

  def form_url_based_on_persistance
    return h.dictionary_words_path(@dictionary, dictionary_id: @dictionary.id) if word.new_record?
    h.word_path(word, dictionary_id: @dictionary.id)
  end


end
