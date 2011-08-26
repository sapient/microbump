Given /^the following posts:$/ do |posts|
  #puts posts.hashes
  Post.create!(posts.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) post$/ do |pos|
  visit posts_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following posts:$/ do |expected_posts_table|
  expected_posts_table.diff!(tableish('table tr', 'td,th'))
end

Given /^Some standard blog entries exist$/ do
  post1 = Factory.create(:post, :title => "First post", :content => "First post content")
  post2 = Factory.create(:post, :title => "Second post", :content => "Second post content")
  post3 = Factory.create(:post, :title => "Third post", :content => "Third post content")
  Factory.create(:post, :title => "Fourth post", :content => "Fourth post")

  post1.publish!
  Timecop.freeze(Time.now - 20.minutes) do
    post2.publish!
  end
  Timecop.freeze(Time.now + 20.minutes) do
    post3.publish!
  end
end