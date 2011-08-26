Given /^a user exists$/ do
  @user = User.create!(:email => "admin@example.com",
                       :name => "Drake Mallard",
                       :password => "password",
                       :password_confirmation => "password",
                       :about => "Meat popsicle" )
end

Given /^the following users exist:$/ do |users|
  users.hashes.each do |u|
    u.merge!({:password_confirmation => u[:password]})
    User.create!(u)
  end
end
