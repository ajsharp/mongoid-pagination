## What

Adds pagination scopes to your mongoid models.

## Usage

```ruby
class Person
  include Mongoid::Document
  include Mongoid::Pagination
end

Person.paginate(:page => 2, :limit => 25) # limit and offset
Person.per_page(25) # just does a limit
```