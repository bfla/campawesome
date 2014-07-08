require 'rails_helper'

describe "authentification" do

  describe "signin page" do

    describe "with valid information" do
       subject { :page }
       before { visit "/users/sign_in"}

       it { should have_content "Sign In" }
     end

  end

end