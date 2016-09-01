Fabricator(:business) do
	name { Faker::Company.name }
	categories(count: 3)
	reviews(count: 3)
end