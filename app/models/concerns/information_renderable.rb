module InformationRenderable
	extend ActiveSupport::Concern

	def information_for_rendering
		persisted? ? self : { errors: errors}
	end

	def status_for_rendering
		persisted? ? {status: 404} : {status: 200}
	end
end
