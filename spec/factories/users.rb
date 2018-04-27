FactoryBot.define do
  factory :user, aliases: [:creator] do
    sequence :email { |x| "#{Faker::Internet.email}#{x}" }
    first_name 'Jonathan'
    last_name 'Doe'
    password 'Password'
  end
end
