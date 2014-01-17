require 'spec_helper'

describe "User pages" do

  subject { page }

  #Listing 9.23: testing user index pg
  describe "index" do

    #Listing 9.33 testing for pagination
    let(:user) { FactoryGirl.create(:user) }
    #like before(:all) to make the users before the rest of our tests or something
    before(:each) do
      sign_in user
      visit users_path
    end
    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "pagination" do

      #the book TALKS about this, but LEAVES IT OUT of the code!
      #the online version HAS THIS!
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }


      it { should have_selector('div.pagination') }
      it "should list each user" do
        #gets 1st pg of users from db
        User.paginate(page:1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    #Listing 9.44: testing for delete links
    describe "delete links" do
      it { should_not have_link('delete')}

      describe "as an admin user" do
        #let(:user) { FactoryGirl.create(:user) }
        let(:admin) { FactoryGirl.create(:admin)}
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end

    before do
      #creating users & sigining in
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "ben", email: "ben@example.com")
      visit users_path
    end

    #checking for pg content
    it { should have_selector('h1',    text: 'All users') }
    it { should have_selector('title', text: 'All users') }

    #pg should display both users created above
    it "should list each user" do
      #display all users from db, match to above users
      User.all.each do |user|
        page.should have_selector('li', text: user.name)
      end
    end

  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    #11.5.4: stats tests for profile pg: following/unfollowing post views
    describe "check stats display" do
      #create the users
      let(:other_user) {FactoryGirl.create(:user) }
      before do
        #make them follow each other
        user.follow!(other_user)
        other_user.follow!(user)
        #open their pg
        visit user_path(user)
      end

      #check that the following/followers count is correct
      it { should have_selector('strong#following', text:'1')}
      it { should have_selector('strong#followers', text:'1')}

      #user unfollows other user
      describe "unfollowing user" do
        before do
          #unfollow the other user
          user.unfollow!(other_user)
          #go to users pg
          visit user_path(user)
        end
        #user's "following path count should decrease"
        it { should have_selector('strong#following', text:'0')}
        it { should have_selector('strong#followers', text:'1')}
      end
      #other user unfollows user
      describe "other user unfollows user" do
              before do
                #unfollow the  user
                other_user.unfollow!(user)
                #go to users pg
                visit user_path(user)
              end
              #user's "following path count should decrease"
              it { should have_selector('strong#following', text:'1')}
              it { should have_selector('strong#followers', text:'0')}
            end
    end

    #11.32: Follow/Unfollow testing
    describe "follow/unfollow buttons" do
      let(:other_user) {FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_selector('input', value: 'Unfollow' )}
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

      describe "toggling the button" do
        before {click_button "Unfollow" }
        it { should have_selector('input', value: 'Follow' ) }
      end
    end
  end
end
  describe "signup page" do
    before { visit signup_path }
    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end


  describe "signup" do

    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end


      describe "with valid information" do
        before do
          fill_in "Name",               with: "Example User"
          fill_in "Email",              with: "user@example.com"
          fill_in "Password",           with: "foobar"
          fill_in "Confirm Password",   with: "foobar"
        end

        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end

        describe "after saving the user" do
          before { click_button submit }
          it { should have_link("Sign out") }
        end

      end
    end

  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    #Ch 9 #1:I did this but really didn't get it
    describe "update forbidden attributes" do
      let(:user) { FactoryGirl.create(:user) }
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end
      before do
        sign_in user, params
        #others say to do these:
        # #sign_in user, no_capybara: true
        #patch user_path(:user), params
      end
      #before { patch user_path(:user), params }
      #specify { expect{user.reload}.not_to be_admin }
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end
    describe "profile page" do
      # Code to make a user variable
      let(:user) { FactoryGirl.create(:user) }
      #10.19: testing showing mp's on the user's pg
      let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
      let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }


      before { visit user_path(user) }

      it { should have_selector('h1',        text: user.name) }
      it { should have_selector('title',     text: user.name) }

      #10.19 - cont'd
      describe "microposts" do
        it { should have_content(m1.content) }
        it { should have_content(m2.content) }
        it { should have_content(user.microposts.count) }
      end
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
  end

  #11.29: test for followed_users & followers pg
  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed user" do
      before do
      sign_in user
        visit following_user_path(user)
      end

      it { should have_selector('title', text: full_title('Following'))}
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user))}
    end

    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_selector('title', text: full_title('Followers'))}
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name, href: user_path(user))}
    end
  end
end

