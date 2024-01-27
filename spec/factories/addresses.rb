FactoryBot.define do
  factory :address do
    cep { "01311-000" }
    street { "MyString" }
    complement { "MyString" }
    district { "MyString" }
    city { "MyString" }
    uf { "MyString" }
    ibge_code { "MyString" }
    citizen
  end
end
