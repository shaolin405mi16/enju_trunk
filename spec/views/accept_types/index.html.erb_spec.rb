require 'spec_helper'

describe "accept_types/index" do
  before(:each) do
    assign(:accept_types, [
      stub_model(AcceptType,
        :name => "Name",
        :display_name => "MyText",
        :note => "MyText",
        :position => 1
      ),
      stub_model(AcceptType,
        :name => "Name",
        :display_name => "MyText",
        :note => "MyText",
        :position => 1
      )
    ])
  end

  it "renders a list of accept_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
