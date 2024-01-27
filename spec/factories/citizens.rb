FactoryBot.define do
  factory :citizen do
    full_name { Faker::Name.unique.name }
    cpf { BRDocuments::CPF.generate }
    cns { "933282321550009" }
    email { Faker::Internet.unique.email }
    birthdate { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
    phone_number { "5519999999999" }
    avatar { "MyString" }
    status { 1 }
  end
end
