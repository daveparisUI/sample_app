#**** users spec vs authentication spec; how do i know which one to use?!

require 'spec_helper'

describe "Authentication" do

  subject { page }

  #****
  describe "authorization" do
    #Listing 9.47: protecting that non-admins can't still get to destroy from command line
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }

        specify { response.should redirect_to(root_url) }
        it "should not delete a user" do
          expect { delete user_path(user) }.not_to change(User, :count)
        end
      end
    end

    #Chapter 9 Ex 9: prevent admin user from deleting themselves
    describe "as admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:admin) { FactoryGirl.create(:admin) }

      before { sign_in admin }

      describe "prevent destroy of themselves by submitting a DELETE request to the Users#destroy action" do
        specify do
              expect { delete user_path(admin) }.not_to change(User, :count).by(-1)
            end
        #before { delete user_path(admin) }
        #
        #specify { response.should redirect_to(root_url) }
      end

    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit user')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_url) }
      end
    end

    #Chapter 9 Ex 6: checking if user is logged in &if so redirecting to root pg when doing new/create
    describe "for signed in users" do
        let(:user) { FactoryGirl.create(:user) }
        before { sign_in user }

        describe "using a 'new' action" do
            before { get new_user_path }
            specify { response.should redirect_to(root_path) }
        end

        describe "using a 'create' action" do
            before { post users_path }
            specify { response.should redirect_to(root_path) }
        end
    end
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      #11.33: tests for Relationship controller authorization
      describe "in the Relationships controller" do
        describe "submitting to the create action" do
          before { post relationships_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete relationship_path(1) }
          specify { response.should redirect_to(signin_path)}
        end
      end

      #Listing 9.17 - Friendly Forwarding
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        #Listing 9.17 - Friendly Forwarding
        describe "after signing in" do
          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end
        end

        #Chapter 9 Ex 8: friendly forwarding only forwards  1x then other times goes to profile pg
        describe "when signing in again" do
          before do
            visit signin_path
            fill_in "Email",      with: user.email
            fill_in "Password",   with: user.password
            click_button "Sign in"
          end

          it "should render the default (profile) page" do
            page.should have_selector('title', text: user.name)
          end
        end
      end

      #10.26: testing for access control of mp's
      describe "in the Microposts controller" do
        describe "submitting to the create action" do
          before { post microposts_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { response.should redirect_to(signin_path) }
        end
      end


      describe "in the Users controller" do
        describe "visiting the user index" do
          #Listing 9.21 testing that index action is protected
          before { visit users_path }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in')}
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        #11.28 auth tests for followers & followings
        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "visiting the followers page" do
          before { visit followers_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

      end
    end
  end
  #****

  #Listing 9.27: testing Users link, making sure pg has all stuff it's supposed to
  #This whole spec looks like a honkin' mess & will probably screw me over
  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    it { should have_selector('title', text: user.name) }

    it { should have_link('Users',      href: users_path) }
    it { should have_link('Profile',    href: user_path(user)) }
    it { should have_link('Settings',   href: edit_user_path(user)) }
    it { should have_link('Sign out',   href: signout_path) }

    it { should_not have_link('Sign in', href: signin_path) }
  end


  describe "signin" do
    before { visit signin_path }

    #Chapter 9 Ex #3
    it { should_not have_link('Users') }
    it { should_not have_link('Profile') }
    it { should_not have_link('Settings') }
    it { should_not have_link('Sign out', href: signout_path) }
    it { should have_link('Sign in', href: signin_path) }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
      it { should have_selector('title', test: user.name) }

      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }

      it { should_not have_link('Sign in', href: signin_path) }



      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end

      #before do
      #  fill_in "Email",    with: user.email.upcase
      #  fill_in "Password", with: user.password
      #  click_button "Sign in"
      #end
      #


      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end




  end

  #i took all this &put it up in the other one, seemed like a good idea
  #describe "Authentication" do
  #  describe "authorization" do
  #    describe "as wrong user" do
  #          let(:user) { FactoryGirl.create(:user) }
  #          let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
  #          before { sign_in user }
  #
  #          describe "visiting Users#edit page" do
  #            before { visit edit_user_path(wrong_user) }
  #            it { should_not have_selector('title', text: full_title('Edit user')) }
  #          end
  #
  #          describe "submitting a PUT request to the Users#update action" do
  #            before { put user_path(wrong_user) }
  #            specify { response.should redirect_to(root_url) }
  #          end
  #        end
  #
  #    describe "for non-signed-in users" do
  #      let(:user) { FactoryGirl.create(:user) }
  #
  #      #Listing 9.17 - Friendly Forwarding
  #      describe "when attempting to visit a protected page" do
  #        before do
  #          visit edit_user_path(user)
  #          fill_in "Email",    with: user.email
  #          fill_in "Password", with: user.password
  #          click_button "Sign in"
  #        end
  #        #Listing 9.17 - Friendly Forwarding
  #        describe "after signing in" do
  #          it "should render the desired protected page" do
  #            page.should have_selector('title', text: 'Edit user')
  #          end
  #        end
  #      end
  #
  #
  #      describe "in the Users controller" do
  #                describe "visiting the user index" do
  #                  #Listing 9.21 testing that index action is protected
  #                  before { visit users_path }
  #                  it { should have_selector('title', text: 'Sign up') }
  #                end
  #
  #                describe "visiting the edit page" do
  #                  before { visit edit_user_path(user) }
  #                  it { should have_selector('title', text: 'Sign in')}
  #                end
  #
  #                describe "submitting to the update action" do
  #                  before { put user_path(user) }
  #                  specify { response.should redirect_to(signin_path) }
  #                end
  #              end
  #    end
  #  end
  #end

end
