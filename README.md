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
  bundle exec ruby prompt_console.rb
```

You can try running with just `ruby prompt_console.rb` on other ruby version, but officially supported one is 2.4.0.

## Ideas for next releases
- extract messaging responsibilities from `Boltonizer` to `Console`: `Boltonizer` should only have coordinates attributes and perform actions, 
and `Console` rescues errors and assigns responses
- Once future requirements come, consider moving direction-related functionality from `Coordinates` to `Boltonizer`
- When robot is growing further we can use decorators for all the upcases in `Boltonizer` and `Command` classes.