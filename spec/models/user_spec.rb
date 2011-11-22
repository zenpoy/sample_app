require 'spec_helper'

describe User do
   before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should reject illegal email addresses" do
    illegal_emails = %w[@ no_at.sign.com no_domain@ two@@at.com comma@gmail,com 
                        two..dots@gmail.com il!egal@chars.com il?egal@gmail.com
                        user@name.com. user@.name.com user.@gmail.com 
                        .user@co.il a@.com user@gmail,.com]
    illegal_emails.each do |email|
      illegal_email_user = User.new(@attr.merge(:email => email))
      illegal_email_user.should_not be_valid
    end
  end
  
  it "should accept legal email addresses" do
    illegal_emails = %w[lot.s.of.dots@gmail.com lots@of.dot.on.the.domain.com CAPS@and.co.il THE_user@yahoo.ru]
    illegal_emails.each do |email|
      illegal_email_user = User.new(@attr.merge(:email => email))
      illegal_email_user.should be_valid
    end
  end
  
  it "should reject duplicate emails" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr.merge(:name => "Different Name"))
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr.merge(:name => "Different Name"))
    user_with_duplicate_email.should_not be_valid
  end
end
