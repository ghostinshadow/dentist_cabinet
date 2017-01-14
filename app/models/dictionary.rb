class Dictionary < ApplicationRecord
  AVAILABLE_RESOURCES = JSON.parse(File.read(Rails.root.to_s + '/lib/dictionary_resources.json'))['resources']
  self.inheritance_column = "resource_type"
  belongs_to :user
  has_many :words, dependent: :destroy

  validates_presence_of :title, :user, :resource_type
  validates_length_of :title, minimum: 1, maximum: 75
  validates_uniqueness_of :resource_type, scope: :user

  scope :work_specific_dictionaries, ->{where(resource_type: ["Theraphy", "Ortodoncy", "Orthopedy", "Surgery"])}

  def self.form_information_about_work_specific_dictionaries
    work_specific_dictionaries = all.work_specific_dictionaries
    {dictionary: work_specific_dictionaries.form_dictionary_with_words,
     info: work_specific_dictionaries.form_dictionary_with_basic_info
     }
  end

  def self.form_dictionary_with_basic_info
    all.inject({})do |info_dict, dictionary|
      info_dict.merge!(dictionary.info_representation)
      info_dict
    end
  end

  def self.form_dictionary_with_words
    all.inject({}) do |overal_works_dictionary, dictionary|
      overal_works_dictionary[dictionary.id] = dictionary.words.select(:id, :dictionary_id, :body)
      overal_works_dictionary
    end
  end


  def self.create_for_user(user)
    AVAILABLE_RESOURCES.each do |resource|
      dictionary = user.dictionaries.where(resource_type: resource['type']).first_or_create do |d|
        d.title = d.title || resource['title']
      end
      resource['words'].each do |word|
        dictionary.words.create(body: word['body'])
      end
    end
  end

end
