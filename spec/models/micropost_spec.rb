require 'spec_helper'

describe Micropost do


  #let(:user) { FactoryGirl.create(:user) }
  #before do
    #this code is WRONG! All attributes are accessible, anyone can change this or any aspect
    #@micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
  #end

  #Chapter 10, Listing 10.5 test to ensure that userid isn't accessible
  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }




  #Chapter 10; Listing 10.2: verify mp obj responds to content & userId attrs
  subject { @micropost }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  #Chapter 10; Listing 10.8: test for mp's users association, testing for micropost.user
  it { should respond_to(:user) }
  its(:user) { should == user }



  #Chapter 10; Listing 10.3: tests for validity of new micropost
  it { should be_valid }
  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  #10.17: tests for mp's model validations
  describe "with blank content" do
    before { @micropost.user_id = nil }
    it {should_not be_valid}
  end
  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end

  #Chapter 10, Listing 10.5: cont'd
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
        end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
  end



  end

