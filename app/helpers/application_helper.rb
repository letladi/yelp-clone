module ApplicationHelper
	def input_error_class(model, property)
		input_error_message(model, property).blank? ? '' : 'form-control-danger'
	end

	def input_error_message(model, property)
		property_error = model.errors[property].uniq.join(' | ')
		property_error.blank? ? '' : property_error
	end

	def container_error_class(model, property)
		model.errors[property].empty? ? 'has-success' : 'has-danger'
	end
end
