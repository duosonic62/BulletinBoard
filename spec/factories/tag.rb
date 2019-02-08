# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :java, class: Tag do
    name { "java" }
  end

  factory :ruby, class: Tag do
    name { "ruby" }
  end
end
