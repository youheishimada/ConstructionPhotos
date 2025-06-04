require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効なファクトリを持つこと" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "emailがないと無効である" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "passwordがないと無効である" do
    user = FactoryBot.build(:user, password: nil)
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "passwordが6文字未満だと無効である" do
    user = FactoryBot.build(:user, password: "12345")
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
end