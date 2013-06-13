require 'spec_helper'

describe "book_details/show" do
  before(:each) do
    @book_detail = assign(:book_detail, stub_model(BookDetail,
      :title => "Title",
      :author => "Author",
      :isbn_number => "Isbn Number",
      :description => "MyText",
      :price => 1.5,
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Author/)
    rendered.should match(/Isbn Number/)
    rendered.should match(/MyText/)
    rendered.should match(/1.5/)
    rendered.should match(/1/)
  end
end
