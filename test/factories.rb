FactoryGirl.define do
  factory :user do
    username "John"
    email  "Doe"
    password "foo"
    admin false
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    username "Admin"
    email "User"
    password "foo"
    admin      true
  end
end