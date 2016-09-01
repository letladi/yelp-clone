require 'rails_helper'

describe Business do
	it { should validate_presence_of(:name) }
	it { should have_and_belong_to_many(:category) }
	it { should have_many(:reviews) }
end