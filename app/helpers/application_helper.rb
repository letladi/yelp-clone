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

	def options_for_category_select(selected=nil)
		options_for_select(Category.all.map { |c| [c.name, c.id] }, selected)
	end

	def review_star_string(rating=0)
		blank_star = '&#9734;'
		star = '&#9733;'
		result = Array.new(5)
		result.fill(blank_star)
		rating.to_i.times do |i|
			result[i] = star
		end
		result.join(' ').html_safe
	end

	def activate_link?(route_name)
		current_page?(route_name) ? 'active' : ''
	end
end
