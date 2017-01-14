class Doctors < Dictionary
	  def info_representation
    {doctors: {name: "Лікарі", id: id}}
  end

  def translated_resource_type
    "Лікарі"
  end
end