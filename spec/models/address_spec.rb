require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:subject) { create(:address) }

  context "db" do
    it { is_expected.to have_db_column(:cep) }
    it { is_expected.to have_db_column(:street) }
    it { is_expected.to have_db_column(:complement) }
    it { is_expected.to have_db_column(:district) }
    it { is_expected.to have_db_column(:city) }
    it { is_expected.to have_db_column(:uf) }
    it { is_expected.to have_db_column(:ibge_code) }
    it { is_expected.to have_db_column(:citizen_id) }
  end

  context "factory" do
    context "valid" do
      it { is_expected.to be_valid }
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:citizen) }
  end

  context "validations" do
    context "presence" do
      it { is_expected.to validate_presence_of(:street) }
      it { is_expected.to validate_presence_of(:district) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:uf) }
    end
    
    context "citizen" do
      it { is_expected.to validate_uniqueness_of(:citizen_id) }
      it { is_expected.to validate_presence_of(:citizen_id) }
    end

    context "cep" do
      it { is_expected.to validate_presence_of(:cep) }

      context "format" do
        context "valid" do
          let(:valid_cep) { "77814-020" }

          it { is_expected.to allow_value(valid_cep).for(:cep) }
        end

        context "invalid" do
          let(:invalid_cep) { "77814020" }

          it { is_expected.to_not allow_value(invalid_cep).for(:cep) }
        end
      end
    end
  end
end
