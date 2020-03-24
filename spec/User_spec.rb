require 'User'

describe User do
  describe "#create" do
    it "can create a new user" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      expect(user).to be_a User
      expect(user.email).to eq "test@makers.com"
    end
    it "hashes the users password" do
      expect(BCrypt::Password).to receive(:create).with('password456')
      User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
    end
  end

  describe ".find" do
    it "can find user by ID" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      result = User.find(user.id)
      expect(result).to be_a User
      expect(result.id).to eq(user.id)
    end
  end
end
