require 'rails_helper'

describe Permission, type: :model do
  context 'relationships' do
    it { should belong_to :user }
  end

  context 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :subject_class }
    it { should validate_presence_of :action }
  end

  context 'methods'
end
