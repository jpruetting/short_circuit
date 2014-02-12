short_circuit
=============

[![Gem Version](https://badge.fury.io/rb/short_circuit.png)](http://badge.fury.io/rb/short_circuit) [![Build Status](https://travis-ci.org/jpruetting/short_circuit.png?branch=master)](https://travis-ci.org/jpruetting/short_circuit)  [![Coverage Status](https://coveralls.io/repos/jpruetting/short_circuit/badge.png?branch=master)](https://coveralls.io/r/jpruetting/short_circuit?branch=master) [![Code Climate](https://codeclimate.com/github/jpruetting/short_circuit.png)](https://codeclimate.com/github/jpruetting/short_circuit)

Short Circuit adds simple presenters for Rails views.


Usage
======

Install the gem in your Gemfile:

```ruby
gem 'short_circuit'
```

Include short_circuit in your model:

```ruby
# app/models/user.rb
 
class User < ActiveRecord::Base
  include ShortCircuit::Presentable

  attr_accessible :first_name, :last_name, :job_title, :member_since
end
```

Create a presenter:

```ruby
# app/presenters/user_presenter.rb
 
class UserPresenter < ShortCircuit::Presenter
  def first_name
    @user.first_name.titleize
  end
 
  def full_name
    "#{first_name} #{last_name}"
  end
 
  def job_title
    @user.job_title || 'not listed'
  end
 
  def member_since
    @user.member_since.to_formatted_s(:long) 
  end
 
  def error_response(method, *args, &block)
    link_to 'N/A', root_path
  end
end
```

No additional controller code is necessary. Retrieve the model as you normally would:

```ruby
# app/controllers/users_controller.rb
 
class UsersController < ApplicationController
  def show
    @user = User.find(params['id'])
  end
end
```

In the view, you don't need to instantiate any presenter/decorator objects, just use the model:

```ruby
# Normal method vs presenter method:
@user.first_name # john
@user.present :first_name # John
 
 
# Missing presenter method is delegated to model:
@user.last_name # smith
@user.present :last_name # smith
 
 
# Method defined on presenter object:
@user.full_name # NoMethodError
@user.present :full_name # John smith
 
 
# Formatted data returned by presenter method:
@user.member_since # 2013-02-28 20:46:32 UTC
@user.present :member_since # February 28, 2013 20:46
 
 
# Presenter method prevents nil error by returning default data:
@user.job_title.upcase # undefined method 'upcase' for nil:NilClass
@user.present(:job_title).upcase # NOT LISTED
 
 
# Presenter method silences nil error and returns alternative content:
@user.not_a_real_method # NoMethodError
@user.present :not_a_real_method # <a href="/">N/A</a>
 
 
# Present! method does not silence errors:
@user.present! :not_a_real_method # NoMethodError
```

Design goals
============
* Minimize project size and scope
* Preserve direct access to model attributes
* Create a separate access point for presenter methods
* Silence accessor errors by default
* Delegate missing presenter methods to the model object
