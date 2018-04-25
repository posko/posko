# POS using rails
  An open source POS written on rails. Hopefully, it can support real world scenario.

  Try it on [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/neume/posko)

# Specs
* Ruby ``` 2.4.2 ```
* Rails ```5.1.6```

# Setting Up
## Database
  This app uses ```postgresql```

  Run ```rake db:create db:migrate db:seed```
### Model Diagram
Reference-style:
![Model Diagram][model-diagram]

[model-diagram]: ../develop/doc/models_brief.svg "Model Diagram"

## Running Test
```bundle exec rspec```

# Mobile App companion
  https://github.com/em4rtinez/posko

# Desktop App
  It will follow after the release of version 1. I plan to utilize the power of ```Electron```

# Contributing
  Contributions/Suggestions are very welcome. https://github.com/neume/posko

# Supported Modules
+ User

# TODOS (Basic Modules)
+ Roles (Ability later)
+ Products
  - composite
+ Variants
+ Collections
+ Orders
+ Payments
+ Customers
+ Cart(ecommerce later)
+ Addresses
+ Contacts
+ Reports(later)
+ Blog(not yet sure)
+ API with Documentation
+ Breadcrumbs
+ Branches
