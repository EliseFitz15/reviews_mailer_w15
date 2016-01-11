## Setting up ActionMailer in Rails
Action Mailer allows you to send emails from your application using mailer classes and views. Mailers work very similarly to controllers.

They inherit from ActionMailer::Base and live in app/mailers, and they have associated views that appear in app/views.

We are going to set up an e-mail to be delivered when a review is created for an item on our review site. To do this in a test driven way, we will start with the test.

###Start with a test & configuring our test environment
* Let's look at this test - we check that the review content is displayed on the page and that we've successfully queued up an email to send.

* Since we don't want to send emails every time we run our full test suite, we can configure the test environment. Rails will default to not send the emails but we can also configure to allow for links by specifying the default url options for this environment with the following line.

- Add to config/test.rb
`config.action_mailer.default_url_options = { host: "localhost", port: 3000 }`

- Add configure to spec_helper to configure cleaning out the deliveries queue

```ruby
config.before :each do
    ActionMailer::Base.deliveries.clear
  end
```

### Where do we start to implement?

- Let's consider where/when in the actions of our app we want to send this mailer. Let's look at the review controller create action.

- `ReviewMailer.new_review(@review).deliver_later`

Run the server and follow rails errors.

#### Mailers like Controllers:
Mailers in Rails tend to behave similarly to controllers. When we call a controller action, it usually retrieves some information and feeds it into a view that transforms it into an HTML page (or whatever format is being requested). A mailer does the same thing: given some information (in this example, a review for a product) we want to generate an email to send to the product owner.

 - Add ApplicationMailer `app/mailers/application_mailer.rb`

```ruby
class ApplicationMailer < ActionMailer::Base
  default from: "Pokedex: Pokemon Review Site <no-reply@pokemonreviewsapp.com>"
end
```

- Add ReviewMailer - "app/mailers/review_mailer.rb"

```ruby
class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review

     mail(
       to: review.pokemon.user.email,
       subject: "New Review for your #{review.pokemon.name}"
     )
  end
end
```
The mail method is similar to render for controllers and is where we can specify the recipient as well as the subject of the mail. It will use the template in app/views/review_mailer/new_review.text.erb by default and have access to any instance variables we've defined (@review in this case).


####Emails like Views:

- Add the view file `app/views/review_mailer/new_review.text.erb`

```
Hello <%= @review.pokemon.user.first_name %>

<%= @review.user.first_name %> has left a new review for your pokemon <%= @review.pokemon.name %>.

You can checkout the review <%= link_to 'here', pokemon_url(@review.pokemon) %>

Gotta catch 'em all!
- Pokemaster Commission
```

Run Test - Passing in our test environment! (Check twice) *But what does it look like?*

###Setting up the development environment

We can use the mailcatcher gem to send test emails in our development environment so we can see what they look like.

- Add to the gemfile in development environment `gem "mailcatcher"` && bundle

- Configure the development environment

```ruby
config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: "localhost",
    port: 1025
  }

  config.action_mailer.default_url_options = {
    host: "localhost",
    port: 3000
  }
```

Test it out.

###Moving it into production

- If heroku has a credit-card on file: `heroku addons:create mandrill:basic`

- Configure our production database

```ruby
config.action_mailer.default_url_options = { host: "pokemonreviews.herokuapp.com" }
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  port: "587",
  address: "smtp.mandrillapp.com",
  user_name: ENV["MANDRILL_USERNAME"],
  password: ENV["MANDRILL_APIKEY"],
  domain: "heroku.com",
  authentication: :plain
}
```

- Configure api keys locally
* `$ heroku config -s | grep MANDRILL_APIKEY >> .env`
* `$ more .env`

- Verify with `heroku config`
