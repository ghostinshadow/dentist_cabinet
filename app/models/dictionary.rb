class Dictionary < ApplicationRecord
  AVAILABLE_RESOURCES = JSON.parse(File.read(Rails.root.to_s + '/lib/dictionary_resources.json'))['resources']

  belongs_to :user, dependent: :destroy
  has_many :words

  validates_presence_of :title, :user, :resource_type
  validates_length_of :title, minimum: 1, maximum: 75
  validates_uniqueness_of :resource_type, scope: :user

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
