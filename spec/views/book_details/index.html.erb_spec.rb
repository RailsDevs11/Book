require 'spec_helper'

describe "book_details/index" do
  before(:each) do
    assign(:book_details, [
      stub_model(BookDetail,
        :title => "Title",
        :author => "Author",
        :isbn_number => "Isbn Number",
        :description => "MyText",
        :price => 1.5,
        :user_id => 1
      ),
      stub_model(BookDetail,
        :title => "Title",
        :author => "Author",
        :isbn_number => "Isbn Number",
        :description => "MyText",
        :price => 1.5,
        :user_id => 1
      )
    ])
  end

  it "renders a list of book_details" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Isbn Number".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
