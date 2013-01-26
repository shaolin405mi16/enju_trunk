require 'spec_helper'

describe "terminals/show" do
  before(:each) do
    @terminal = assign(:terminal, stub_model(Terminal,
      :ipaddr => "Ipaddr",
      :name => "Name",
      :comment => "Comment",
      :checkouts_autoprint => false,
      :reserve_autoprint => false,
      :manifestation_autoprint => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ipaddr/)
    rendered.should match(/Name/)
    rendered.should match(/Comment/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
