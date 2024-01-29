require 'rails_helper'

RSpec.describe "citizens/edit", type: :view do
  let(:citizen) {
    Citizen.create!()
  }

  before(:each) do
    assign(:citizen, citizen)
  end

  it "renders the edit citizen form" do
    render

    assert_select "form[action=?][method=?]", citizen_path(citizen), "post" do
    end
  end
end
