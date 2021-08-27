# MoneticoPaiement

MoneticoPaiement is a gem to ease credit card payment with [Monetico Paiement](https://www.monetico-paiement.fr/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'monetico_paiement'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install monetico_paiement

## Usage

The EPT can be configured in an initialiser (`config/initializers/monetico_paiement.rb`):

```ruby
MoneticoPaiement.configure do |config|
  config.hmac_key = "################################"
  config.ept_number = "######"
  config.company_code = "########"

  config.env = :test # or :production
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/monetico_paiement.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
