require 'rails_helper'

RSpec.describe CitizensHelper, type: :helper do
  describe "citizens_statuses_for_select" do
    let(:expected) { [["Ativo", "active"], ["Inativo", "inactive"]] }

    it { expect(citizens_statuses_for_select).to eq(expected) }
  end
end
