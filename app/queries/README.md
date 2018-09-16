# Query Object
This objects acts as an intermediary  to Activerecord through hash options. It
includes pagination and other filter options. It also accepts secure params directly
from controllers. This object is ideal for APIs that renders collections.

## When to use
If you have to let the user decide the data to be returned. Example:
- Displaying list of active users after an specified `id`
- Displaying `products` by page
- Displaying records according to inputted filters

## How to Use
Implementation of this object might change in the future. For more infor check [Queryko](https://github.com/neume/queryko) gem

Procedure:

- Create a class with `Queryko::QueryObject` as base class.
- Define `initalize` method with 2 arguments. The first is the options or params.
The second is the relation. It accepts an `ActiveRecord` object or an
`ActiveRecord::Relation`.
``` ruby
  class ProductsQuery < Queryko::QueryObject
    def initialize params={}, relation = Product.all
      super(params, relation)
    end
  end
```
- Add query filters.
  - `add_range_attributes :attribute` filters query with `attribute_min` and `attribute_max`
  - `add_searchables :attribute` filters query by `:attribute` if the attribute is supplied
```ruby
  class ProductsQuery < Queryko::QueryObject
    add_range_attributes :created_at, :price
    add_searchables :name, :vendor

    ...
  end
```
- Instaniate and execute `call` method.
```ruby
products = ProductsQuery.new(price_min: 100, price_max: 150, name: 'Milk').call
```
