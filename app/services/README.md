# Service Objects
This object serves as an encapsulation of business logic. It makes the model/controller slim
by extracting logic to a service object.

## When to use
Here are some conditions that might help to decide when to use service objects:
- If the business logic requires 2 or more models to make it work
- If it has too many queries
- If controller action contains more than 5-10 lines of code

## How to use
- Create a class with `ServiceObject` as base class.
- Add `initialize` definition. Load all necessary here. Example:
``` ruby
  def initialize(options={})
    @name = options.fetch(:amount)
  end
```
- Define ```perform_service``` method. The main business logic is expected to to
be executed here. Enclose database queries inside transaction as much as possible.
Example:
``` ruby
  def perform_service
    Account.transaction do
      ... # queries here
    end
  end
```
## TODOs
- Use ActiveModel::Errors for data structure for error
- Properly implement validation
