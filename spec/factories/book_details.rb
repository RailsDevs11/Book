# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book_detail do
    title "MyString"
    author "MyString"
    isbn_number "MyString"
    description "MyText"
    price 1.5
    user_id 1
  end
end
