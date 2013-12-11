FactoryGirl.define do
  #factory :user do
  #  name "Michael Hartl"
  #  email "michael@example.com"
  #  password "foobar"
  #  password_confirmation "foobar"
  #end

  #Listing 9.32: using FactoryGirl to simulate a bunch of test users
  factory :user do
    sequence(:name)       { |n| "Person #{n}" }
    sequence(:email)      { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    #Listing 9.43: making admin factory to create admin users during testing
    factory :admin do
      admin true
    end
  end
end