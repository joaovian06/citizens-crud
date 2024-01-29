require 'rails_helper'

RSpec.describe "citizens/index", type: :view do
  let(:citizens) { create_list(:citizen, 10) }
  before(:each) do
    assign(:citizens, citizens)
  end

  it "renders a list of citizens" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
