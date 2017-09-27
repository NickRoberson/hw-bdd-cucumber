# Add a declarative step here for populating the DB with movies.

# PART 1 

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)  
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# PART 2 

When /I (un)?check the following ratings: (.*)/ do |uncheck, ratings|
  if uncheck == "un"
    ratings.split(', ').each {|x| step %{I uncheck "ratings_#{x}"}}
  else
    ratings.split(', ').each {|x| step %{I check "ratings_#{x}"}}
  end
  # HINT: use String#split to split up the rating_list, then
  # iterate over the ratings and reuse the "When I check..." or
  # "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should not see any of the movies/ do
  rowCount = page.all('#movies tr').size - 1
  assert rowCount == 0
end

Then /I should see all the movies/ do
  rowCount = page.all('#movies tr').size - 1
  assert rowCount == Movie.count()
end

# PART 3 

