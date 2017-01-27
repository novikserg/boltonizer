# boltonizer
A next-generation Skynet invention, sent back in time to conquer the 5x5 tables

 <img src="http://cbsnews1.cbsistatic.com/hub/i/2013/03/06/5bab1b1c-a645-11e2-a3f0-029118418759/ctm_bolton_030613.jpg" width="500px"> 

## Requirements
- Ruby 2.4.0

## Installation
```
  bundle install
  bundle exec rspec
```

## Usage
Run with 
```
  ruby prompt_console.rb
```

Hey Locomote fellas :)   
Unfortunately I didn't have enough time to finish it - it works, but could be better. Also that's the reason why unit tests are lacking.   
I started with integration tests covering most scenarios, so while it has no bugs, unit-tests would be more bullet-proof for sure. For a big feature like this robot I would usually write unit-tests after the actual code (and when feature is small enough and has very specific requirements, 
I will start with tests first. Also, tests always go first for bug-fixes and minor adjustments.

Things this robot can use when growing further:
- outputs can be moved to decorators (all the upcases in `Boltonizer` and `Command` classes)
- I would also tinker more with method responsibilities
- something else I meant to mention but forgot :( woops

Anyways, time to go. Cheers!

