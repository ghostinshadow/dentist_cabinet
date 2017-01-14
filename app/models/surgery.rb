class Surgery < Dictionary
	
  def info_representation
    {surgery: {name: "Хірургія", id: id}}
  end

  def translated_resource_type
    "Хірургія"
  end
end
