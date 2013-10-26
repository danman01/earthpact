# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pact do
    agreed false
    balance "9.99"
    penalty "9.99"
  end
end
