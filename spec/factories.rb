Factory.define :user do |user|
# user.name                    "Evan Misshula"
# user.email                   "evanisshula@gmail.com"
# user.password                "em1234"
# user.password_confirmation   "em1234"
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
