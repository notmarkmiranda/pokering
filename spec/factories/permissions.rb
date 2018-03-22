FactoryBot.define do
  factory :permission do
    user
    subject_class 'League'
    action 'new'
  end
end
