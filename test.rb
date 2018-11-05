require 'capybara/dsl'

describe 'Example' do
  include Capybara::DSL

  before do
    Capybara.configure do |config|
      config.run_server = false
      config.default_driver = :selenium_chrome
      config.app_host = 'localhost:8080'
    end

    visit '/index.html'
  end

  it 'says hello when you click the link' do
    click_link 'Say Hello'
    expect(find('#test-subject').text).to eq 'Hello, world!'
  end
end
