# Add a declarative step here for populating the DB with movies.

# PART 1 

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    # make each movie 
    Movie.create!(movie)  
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  # make sure the right number of movies exist 
  Movie.count.should be n_seeds.to_i
end

# PART 2 

When /I uncheck the following ratings: (.*)/ do |ratings|
  # for each rating, uncheck that rating
  ratings.split(', ').each {|x| step %{I uncheck "ratings_#{x}"}}
end

When /I check the following ratings: (.*)/ do |ratings|
  # for each rating, check that rating 
  ratings.split(', ').each {|x| step %{I check "ratings_#{x}"}}
end

Then /I should see all of the movies/ do
  # get row count and movie count
  rows = page.all('#movies tr').size - 1
  movies = Movie.count()
  # print to verify 
  puts rows 
  puts movies
  assert rows == movies
end

# PART 3 

# use regex to make sure that movies are sorted
Then /I should see "(.*)" before "(.*)"/ do |movie1, movie2|
  check = page.body.match(/.* #{movie2}/)
  # make sure movie1 comes before movie2
  assert check =~ /#{movie1}/ 
end