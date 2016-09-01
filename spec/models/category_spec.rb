require 'rails_helper'

describe Category do 
	it { should have_and_belong_to_many(:businesses) }
	it { should validate_presence_of(:name) }
	it { should validate_uniqueness_of(:name).case_insensitive }
end