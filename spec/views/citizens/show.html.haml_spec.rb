require 'rails_helper'

RSpec.describe "citizens/show", type: :view do
  before(:each) do
    assign(:citizen, Citizen.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
