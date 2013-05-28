short-circuit
=============

[![Build Status](https://travis-ci.org/jpruetting/short-circuit.png?branch=master)](https://travis-ci.org/jpruetting/short-circuit)

Short Circuit enables simple presenters for Rails views.


Installation
=============

Include the gem in your Gemfile:

```ruby
gem 'short-circuit'
```

Usage
=============

Model:

```ruby
class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :job_title, :member_since
end
```

Presenter:

```ruby
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

Examples:

```ruby
@user = User.new(
  first_name: 'john',
  last_name: 'smith',
  job_title: nil,
  member_since: 3.months.ago
)

@user.first_name # john
@user.present :first_name # John

@user.last_name # smith
@user.present :last_name # smith

@user.full_name # NoMethodError
@user.present :full_name # John smith

@user.member_since # 2013-02-28 20:46:32 UTC
@user.present :member_since # February 28, 2013 20:46

@user.job_title.upcase # undefined method 'upcase' for nil:NilClass
@user.present(:job_title).upcase # NOT LISTED

@user.not_a_real_method # NoMethodError
@user.present :not_a_real_method # <a href="/">N/A</a>

@user.present! :not_a_real_method # NoMethodError
```

Design Decisions
=============
* All presenter methods are accessed via 'present' and 'present!'. This helps identify whether the output is coming from the presenter or directly from the model. It also keeps intact the familiar and direct access to a model's attributes.
* The 'present' method will fail silently. This keeps minor accessor errors from breaking an entire page. Errors can still be logged/handled via the 'error_response' method.
* If you do not want a particular method call to fail silently, the 'present!' method will throw errors as usual.
* If a method is not found on the presenter, it will delegate the call to the model.
