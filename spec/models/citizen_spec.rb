require 'rails_helper'

RSpec.describe Citizen, type: :model do
  let(:subject) { create(:citizen) }

  context "db" do
    context "columns" do
      it { is_expected.to have_db_column(:full_name) }
      it { is_expected.to have_db_column(:cpf) }
      it { is_expected.to have_db_column(:cns) }
      it { is_expected.to have_db_column(:email) }
      it { is_expected.to have_db_column(:birthdate) }
      it { is_expected.to have_db_column(:phone_number) }
      it { is_expected.to have_db_column(:avatar) }
      it { is_expected.to have_db_column(:status) }
    end

    context "indexes" do
      it { is_expected.to have_db_index(:cns) }
      it { is_expected.to have_db_index(:cpf) }
      it { is_expected.to have_db_index(:email) }
      it { is_expected.to have_db_index(:full_name) }
    end
  end

  context "associations" do
    it { is_expected.to have_one(:address) }
  end

  context "enum" do
    it { is_expected.to define_enum_for(:status).with_values(active: 0, inactive: 1) }
  end

  context "factory" do
    context "valid" do
      it { is_expected.to be_valid }
    end
  end

  context "validations" do
    context "presence" do
      let(:subject) { build(:citizen) }

      it { is_expected.to validate_presence_of(:phone_number) }
      it { is_expected.to validate_presence_of(:status) }
      it { is_expected.to validate_presence_of(:avatar) }
    end

    context "phone number" do
      context "valid" do
        context "formatted" do
          let(:formatted_phone_number) { "+55 19 99999-9999" }

          it { is_expected.to allow_value(formatted_phone_number).for(:phone_number) }
        end

        context "unformatted" do
          let(:unformatted_phone_number) { "5519999999999" }
            
          it { is_expected.to allow_value(unformatted_phone_number).for(:phone_number) }
        end
      end
    end

    context "birthdate" do
      it { is_expected.to validate_presence_of(:birthdate) }

      context "can not be greater than today" do
        let(:tomorrow) { Date.tomorrow }
        let(:subject) { build(:citizen, birthdate: tomorrow) }

        it { expect(subject.validate).to be_falsy }
      end

      context "can not be less than 22nd April 1500" do
        let(:brazil_age) { Date.parse("22nd, Apr 1500") }
        let(:subject) { build(:citizen, birthdate: brazil_age) }

        it { expect(subject.validate).to be_falsy }
      end
    end

    context "full name" do
      let(:subject) { build(:citizen) }

      it { is_expected.to validate_presence_of(:full_name) }
      it { is_expected.to validate_uniqueness_of(:full_name) }
    end

    context "cpf" do
      let(:subject) { build(:citizen) }
      
      it { is_expected.to validate_presence_of(:cpf) }
      it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }

      context "format" do
        context "valid" do
          context "formatted" do
            let(:valid_cpf) { BRDocuments::CPF.generate } # Formatted CPF
            
            it { is_expected.to allow_value(valid_cpf).for(:cpf) }
          end

          context "not formatted" do
            let(:valid_cpf) { BRDocuments::CPF.generate(false) } # Not Formatted CPF
            
            it { is_expected.to allow_value(valid_cpf).for(:cpf) }
          end
        end

        context "invalid" do
          let(:invalid_cpf) { "999.999.999-99" }
          
          it { is_expected.to_not allow_value(invalid_cpf).for(:cpf) }
        end
      end
    end

    context "cns" do
      context "valid" do
        let(:subject) { build(:citizen) }
        let(:valid_cns) { "933282321550009" }

        it { is_expected.to validate_presence_of(:cns) }
        it { is_expected.to validate_uniqueness_of(:cns).case_insensitive }
        it { is_expected.to validate_length_of(:cns).is_equal_to(15) }
        it { is_expected.to allow_value(valid_cns).for(:cns).with_message("Nao segue o padrao para o CNS") }
      end

      context "invalid" do
        let(:invalid_cns) { "xxxxxxxxxxxxxxx" }
        let(:subject) { build(:citizen, cns: invalid_cns) }

        it { is_expected.to_not allow_value(invalid_cns).for(:cns) }
      end
    end

    context "email" do
      let(:subject) { build(:citizen) }

      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email) }

      context "format" do
        let(:valid_email) { "teste@teste.com" }
        let(:invalid_email) { "thisisnotanemail.com" }

        it { is_expected.to allow_value(valid_email).for(:email) }
        it { is_expected.to_not allow_value(invalid_email).for(:email) }
      end
    end
  end

  context "methods" do
    context "callback" do
      context "#before_save" do
        describe "format_cpf" do
          let(:unformatted_cpf) { BRDocuments::CPF.generate(false) }
          let(:formatted_cpf) { BRDocuments::CPF.pretty(unformatted_cpf) }
          let(:subject) { build(:citizen, cpf: unformatted_cpf) }

          before do
            subject.save!
            subject.reload
          end

          it { expect(subject.cpf).to eq(formatted_cpf) }
        end
      end

      context "#before_validate" do
        describe "format_phone_number" do
          let(:unformatted_phone_regex) { %r(\A(\d{2})(\d{2})(\d{4,5})(\d{4})\z) }
          let(:unformatted_phone_number) { BRDocuments::CPF.generate(false) }
          let(:formatted_phone_number) { unformatted_phone_number.gsub(unformatted_phone_regex, '+\1 \2 \3-\4' ) }
          let(:subject) { build(:citizen, phone_number: unformatted_phone_number) }

          before do
            subject.validate
          end

          fit { expect(subject.phone_number).to eq(formatted_phone_number) }
        end
      end
    end
  end
end
