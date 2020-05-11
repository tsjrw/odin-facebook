require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  describe "GET /" do
    it "should be the root page" do
      get root_path
      expect(response).to render_template('home')
      expect(response).to be_successful
    end
  end

end
