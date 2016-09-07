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

	def options_for_rating_select(selected=nil)
		valid_ratings = (Review::MIN_RATING..Review::MAX_RATING).to_a
		options_for_select(valid_ratings.map { |c| [pluralize(c, 'star'), c] }, selected)
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

	def plural_word_by_count(num, word) 
		pluralized_result = pluralize(num, word)
		num, plural_word = pluralized_result.split(' ')
		plural_word
	end

	def short_date(date)
		date.strftime("%d/%m/%Y")
	end

	def business_page?
		business = Business.find_by(id: params[:id])
		return false if business.nil?
		current_page?(business_path(business))
	end
end
