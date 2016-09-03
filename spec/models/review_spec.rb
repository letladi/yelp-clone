require 'rails_helper'

describe Review do 
	it { should belong_to(:business) }
	it { should belong_to(:user) }
	it { should validate_presence_of(:rating) }
	it { should validate_inclusion_of(:rating).in_range(1..5) }
	it { should validate_presence_of(:description) }
	it { should validate_uniqueness_of(:user_id).scoped_to(:business_id) }
end