# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Tag, type: :model do

  before do
    create(:java_tag)
  end

  context 'tagモデルに正常な値を渡す' do
    # java_tagと被っていない正常な情報を準備
    let(:ruby_tag) { build(:ruby_tag) }

    it 'validationにかからないこと' do
      ruby_tag.valid?
      expect(ruby_tag).to be_valid
    end
   end

   context 'tagモデルに異常な値を渡す' do
    it 'presenceが効くこと' do
      tag = Tag.new()
      tag.valid?
      expect(tag.errors.messages[:name]).to include('を入力してください')
    end

    it 'uniquenessが効くこと' do
      tag = build(:java_tag)
      tag.valid?
      expect(tag.errors.messages[:name]).to include('はすでに存在します')
    end

    it 'lengthが効くこと' do
      tag = Tag.new(name: 'a' * 21)
      tag.valid?
      expect(tag.errors.messages[:name]).to include('は20文字以内で入力してください')

      tag = Tag.new(name: 'a' * 20)
      tag.valid?
      expect(tag.errors.messages[:name]).not_to include('は20文字以内で入力してください')
    end
   end
end
