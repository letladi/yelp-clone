Fabricator(:business) do
	name { Faker::Company.name }
	category
end