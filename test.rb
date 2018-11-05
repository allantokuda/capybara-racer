require 'capybara/dsl'

describe 'Capybara' do
  include Capybara::DSL

  before do
    Capybara.configure do |config|
      config.run_server = false
      config.default_driver = :selenium_chrome
      config.app_host = 'localhost:8080'
    end

    visit '/race_condition.html'
  end

  it 'waits for the page to change' do
    click_link 'Change'
    expect(find('#test-subject')).to have_content 'Hello, world!'
  end

  it 'does not wait any longer than it needs to' do
    fill_in 'Delay', with: 500
    click_link 'Change'

    start_time = Time.now
    expect(find('#test-subject')).to have_content 'Hello, world!'
    end_time = Time.now

    expect(end_time - start_time).to be < 0.6 # seconds
  end

  it 'only waits up to a timeout (default of 2 seconds) for changes' do
    fill_in 'Delay', with: 2500 # JavaScript setTimeout() milliseconds
    click_link 'Change'
    expect(find('#test-subject')).to_not have_content 'Hello, world!'
  end

  it 'allows wait time to be overridden' do
    fill_in 'Delay', with: 2500
    click_link 'Change'
    using_wait_time(3) do # Capybara seconds
      expect(find('#test-subject')).to have_content 'Hello, world!'
    end
  end

  it 'can help you even when you are not working with it directly' do
    # Actually, it can't (reliably) help you, which is why this test fails.

    # The race starts here...
    click_link 'Change'

    # You can play with this sleep value to slow down the test and make it "pass".
    # But this is NOT recommended. Much better to let Capybara poll the site for you.
    sleep(0.5)

    # Here we are calling `text` on what Capybara found.
    # The result of that is a string, not a Capybara object. All Capybara can
    # do is hand over the value once it's found, and assume you know what you're doing.
    # Then when we immediately check its value, we're asserting our change
    # condition before the page has updated, so the test fails.
    expect(find('#test-subject').text).to eq 'Hello, world!'
  end
end
