# Form Object
It handles validation of user inputs. It then process the input or pass it to service object. Its main purpose is to ensure that inputs are correct before processing.

## When to use
One of these reason might be enough to create a service object.
- If you need a validation for user inputs
- If a service object is executed with user inputs
- If you do not like to implement nested atributes on models

## How to use
- Create a class with `FormObject` as base.
- Then add attributes using:
``` ruby
attr_accessor(:first_name, :last_name)
```
- Then add validations like how you add validations on model


Refer to `registration_form.rb` for more info.
