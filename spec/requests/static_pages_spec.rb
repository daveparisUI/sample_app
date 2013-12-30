require 'spec_helper'

describe "Static Pages" do

#  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"

    it { should_not have_selector 'title', text: '| Home' }

    #10.40: test for rendering feed on home pg
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      #10.5.4: test to make sure delete links do not appear for microposts not created by the current user
      let(:another_user) { FactoryGirl.create(:user) }
      before { @another_users_mp = another_user.microposts.build(content: "You cannot delete this") }

      describe "user should not see delete of another user's post" do
        it { page.should_not have_selector("delete", href: user.microposts(@another_users_mp)) }
      end

      before do
        #10.5 Ex. 1: paginate, after 30 entries
        31.times { FactoryGirl.create(:micropost, user: user) }
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")



        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        x = 0
        user.feed.each do |item|
          #that the first # in li##{item.id} is Capybara syntax for a CSS id, whereas the second # is the beginning of a Ruby string interpolation #{}.
          if x <  30
            page.should have_selector("li##{item.id}", text: item.content)
          else
            #10.5.2: testing for pagination
            page.should_not have_selector("li##{item.id}", text: item.content)
          end
          x += 1
        end

        #10.5.4: cont'd

      end
      #10.5 Ex. 1: sidebar mp count & pluralized
      it "should have micropost count and be plural" do
        page.should have_content("#{user.feed.count} microposts")
      end
    end

    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      page.should have_selector 'title', text: full_title('About Us')
      click_link "Help"
      page.should # fill in
      click_link "Contact"
      page.should # fill in
      click_link "Home"
      click_link "Sign up now!"
      page.should # fill in
      click_link "sample app"
      page.should #fill in

      #it { should have_selector('h1', text: 'Sample App') }
      #it { should have_selector('title', text: full_title('')) }
      #it { should_not have_selector 'title', :text => '| Home' }
    end
    #
    #it "should have the content 'Sample App'" do
    #  visit '/static_pages/home'
    #  page.should have_content('Sample App')
    #end

    describe "Help Page" do
      before { visit help_path }

      it { should have_selector('h1', text: 'Help') }
      it { should have_selector('title', text: full_title('Help')) }

      #it "should have the title 'Help'" do
      #  page.should have_selector('title', :text => "#{base_title} | Help")
      #end

      #it "should have the content 'Help'" do
      #  visit '/static_pages/help'
      #  page.should have_content('Help')
      #end
    end


    describe "About Page" do
      before { visit about_path }
      it { should have_selector('h1', text: 'About') }
      it { should have_selector('title', text: full_title('About Us')) }
    end

    describe "Contact page" do
      before { visit contact_path }

      it "should exist'" do
      end

      it { should have_selector('h1', text: 'Contact') }
      it { should have_selector('title', text: full_title('Contact')) }

    end
  end
end