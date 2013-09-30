require 'spec_helper'

describe "Static Pages" do

#  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1', text: 'Sample App') }

    it { should have_selector('title', text: full_title('')) }


    it { should_not have_selector 'title', :text => '| Home' }
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
