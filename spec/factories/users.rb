FactoryBot.define do
  factory :user, aliases: [:creator] do
    email 'test@example.com'
    first_name 'Jonathan'
    last_name 'Doe'
    password 'Password'
  end
end
