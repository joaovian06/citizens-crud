FactoryBot.define do
  factory :citizen do
    full_name { Faker::Name.unique.name }
    cpf { BRDocuments::CPF.generate }
    cns { "#{Faker::Number.unique.number(digits: 15)}" }
    email { Faker::Internet.unique.email }
    birthdate { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
    phone_number { "5519999999999" }
    avatar { "MyString" }
    status { %w(active inactive).sample }
    address

    trait :invalid_citizen do
      full_name { nil }
      cpf { nil }
      cns { nil }
      email { nil }
      birthdate { nil }
      phone_number { nil }
      avatar { nil }
      status { nil }
    end
  end
end
