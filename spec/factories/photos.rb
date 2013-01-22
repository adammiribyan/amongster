# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    path "MyString"
    cursor "MyString"
    rev "MyString"
    url_expires_at 2.hours.from_now
  end
end
