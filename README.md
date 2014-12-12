# Timing-sensitive Capybara example

In my experience I've seen [Capybara](https://github.com/jnicklas/capybara) users encounter some common mistakes, of this form:

    expect(find('#test-subject').text).to eq 'Hello, world!'

That may work for a static webpage, but when testing dynamic webpages it
becomes a race condition, often with "flickering" (inconsistent)
test failures that can be difficult to debug. This project is an attempt to
distill the critical issues concerning the use of Capybara into simple examples
that will help people enjoy its power without going through typical newcomer
frustration.

# Instructions

To run the example tests:

    http-server .
    rspec -f d test.rb

Note that the last test is _expected_ to fail. :)
