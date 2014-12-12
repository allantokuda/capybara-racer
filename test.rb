require 'capybara'

describe 'Capybara' do
  include Capybara::DSL

  before do
    Capybara.configure do |config|
      config.run_server = false
      config.default_driver = :selenium
      config.app_host = 'localhost:8080'
    end

    visit '/race_condition.html'
  end

  it 'waits for the page to change' do
    click_link 'Change'
    expect(find('#test-subject')).to have_text 'Hello, world!'
  end

  it 'allows wait time to be overridden' do
    using_wait_time(200) do
      # expect that the field does not change during the first 200 milliseconds.
      expect(find('#test-subject').text).to_not eq 'Hello, world!'
    end
  end

  it 'can help you even when you are not working with it directly' do
    expect(find('#test-subject').text).to eq 'Hello, world!'
  end
end
