require 'User'

describe User do
  describe "#create" do
    it "can create a new user" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      expect(user).to be_a User
      expect(user.email).to eq "test@makers.com"
    end


  end
end