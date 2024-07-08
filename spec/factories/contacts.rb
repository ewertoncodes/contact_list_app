
FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "Contact #{n}" }
    cpf { CPF.generate }
    phone { '123456789' }
    address { 'Rua Exemplo, 123' }
    postalcode { '12345-678' }
    latitude { 123.456 }
    longitude { 456.789 }
    association :user
  end
end
