# Kenna


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kenna'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kenna

## Usage

Get an Api Instance

Test token ty9hxcpmgdrvnuqe
@api = Kenna::Api.new("your_token")

Test token ty9hxcpmgdrvnuqe
@api = Kenna::Api.new("ty9hxcpmgdrvnuqe")

There are basic crud methods that return a Response Object, 
    use .body to get the JSON 
    use .code to get the response code
    use .headers to get the headers
    'resource' is the root name of the endpoint, such as 'users'
TODO: Several methods are responding only with body and need to be refactored
TODO: Address throttling issues

@api.post(uri, body)
@api.postByResource(resource, body)
@api.get(uri)
@api.getById(resource, id)
@api.update(uri, body)
@api.updateById(resource, id, body)
@api.delete(uri)
@api.deleteById(resource, id)

The following are two examples of shortcut methods,
I intend to provide these for all routes

Get All Users (only up to 500 for now)
@users = @api.getAllUsers()
puts @users

Getting the first User ID (there should always be at least one)
@user_id = @users[0]['id']

Get A Single User by ID
@user = @api.getUserById(@user_id)
puts @user

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kenna. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Kenna project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/kenna/blob/master/CODE_OF_CONDUCT.md).
