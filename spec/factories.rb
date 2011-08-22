FactoryGirl.define do
  factory :post do
    sequence :title do |n|
      "Title of post #{n}"
    end
    content "This is an awesome post"
  end
end