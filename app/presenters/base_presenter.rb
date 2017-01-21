class BasePresenter
	def initialize(object, template, *helper_objects)
		@object = object
		@template = template
	end

	def h
		@template
	end

	def self.presents(name)
		define_method(name) do
			@object
		end
	end
end