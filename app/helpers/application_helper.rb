module ApplicationHelper
	def present(object: , klass: nil, helper_object: nil)
		klass ||= "#{object.class}Presenter".constantize
		presenter = klass.new(object, self, helper_object)
		yield presenter if block_given?
		presenter
	end
end
