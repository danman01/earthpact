# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    charity_split 1.5
    earthpact_split 1.5
    amount "9.99"
    last_four 1
    payment_provider "MyString"
  end
end
