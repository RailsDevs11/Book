require "spec_helper"

describe BookDetailsController do
  describe "routing" do

    it "routes to #index" do
      get("/book_details").should route_to("book_details#index")
    end

    it "routes to #new" do
      get("/book_details/new").should route_to("book_details#new")
    end

    it "routes to #show" do
      get("/book_details/1").should route_to("book_details#show", :id => "1")
    end

    it "routes to #edit" do
      get("/book_details/1/edit").should route_to("book_details#edit", :id => "1")
    end

    it "routes to #create" do
      post("/book_details").should route_to("book_details#create")
    end

    it "routes to #update" do
      put("/book_details/1").should route_to("book_details#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/book_details/1").should route_to("book_details#destroy", :id => "1")
    end

  end
end
