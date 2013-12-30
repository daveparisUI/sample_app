FactoryGirl.define do
  #factory :user do
  #  name "Michael Hartl"
  #  email "michael@example.com"
  #  password "foobar"
  #  password_confirmation "foobar"
  #end

  #Listing 9.32: using FactoryGirl to simulate a bunch of test users
  factory :user do
    #name "Michael Hartl"
    #email "michael@example.com"

    #10.12: updates w/factory for mp's
    sequence(:name)    { |n| "Person #{n}" }
    sequence(:email)   { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  #10.12 cont'd
  factory :micropost do
    content "Lorem ipsum"
    #telling FactoryGirl about mp's assoc'd user by incl. in def of factory:
    user

    ##Listing 9.43: making admin factory to create admin users during testing
    #factory :admin do
    #  admin true
    #end
  end
end