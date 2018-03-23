FactoryBot.define do
  factory :permission do
    user
    subject_class 'League'
    subject_id nil
    action 'new'
  end
end
