require 'spec_helper'

describe "book_details/new" do
  before(:each) do
    assign(:book_detail, stub_model(BookDetail,
      :title => "MyString",
      :author => "MyString",
      :isbn_number => "MyString",
      :description => "MyText",
      :price => 1.5,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new book_detail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => book_details_path, :method => "post" do
      assert_select "input#book_detail_title", :name => "book_detail[title]"
      assert_select "input#book_detail_author", :name => "book_detail[author]"
      assert_select "input#book_detail_isbn_number", :name => "book_detail[isbn_number]"
      assert_select "textarea#book_detail_description", :name => "book_detail[description]"
      assert_select "input#book_detail_price", :name => "book_detail[price]"
      assert_select "input#book_detail_user_id", :name => "book_detail[user_id]"
    end
  end
end
