# POS using rails [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/neume/posko/tree/develop)
  An open source POS written on rails. Hopefully, it can support real world scenario.


[![Build Status](https://travis-ci.org/neume/posko.svg?branch=develop)](https://travis-ci.org/neume/posko)
[![Maintainability](https://api.codeclimate.com/v1/badges/12cd8cf666a27e7c7b10/maintainability)](https://codeclimate.com/github/neume/posko/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/12cd8cf666a27e7c7b10/test_coverage)](https://codeclimate.com/github/neume/posko/test_coverage)
[![CodeFactor](https://www.codefactor.io/repository/github/neume/posko/badge)](https://www.codefactor.io/repository/github/neume/posko)

# Specs
* Tested on Ruby ``` 2.4.3 ```
* Rails ```5.1.6```

# Setting Up
## First Time
  Run ``` bin/setup ```

## Else (development)
  Instead of ```db:rollback && db:migrate```,

  Run ``` bin/update ```

  This command will drop your database and recreates it. **Your data will be purged**.


### Model Diagram
![Model Diagram][model-diagram]

[model-diagram]: ../develop/doc/models_brief.svg "Model Diagram"

## Running Test
  bundle exec rspec
or
  bundle exec guard
# Dashboard Preview

![Preview][preview]

[preview]: ../develop/app/assets/images/sample.png "Preview"


# API
## Documentation
The API references is available on [POSko API Docs](https://neume.github.io/posko-api-docs/).

You can contribute by documenting our API [here](https://github.com/neume/posko-api-docs).

## Postman
[Here](https://www.getpostman.com/collections/9dfaf1eb5d5768ecaae0)'s the postman collection.

There are some automations implemented there using postman test script. It stores your token and then includes it on requests with authorization procedure.

You need to set up your environment variables to fully utilize that automation. These are the variables this collection needs:

| Variable     |          Value          |
|:-------------|:-----------------------:|
| url          |  https://localhost:300  |
| account_name |      first_company      |
| email        | admin@first_company.com |
| password     |          pass           |

These variables are based on rails defaults and seed data. Change it according to your needs.

# Mobile App companion
[Android App](https://github.com/edwnmrtnz/posko) by [edwnmrtnz](https://github.com/edwnmrtnz)

# Desktop App
  It will follow after the release of version 1. I plan to utilize the power of ```Electron```

# Contributing
  Contributions/Suggestions are very welcome. Check it out [here](https://github.com/neume/posko])

  There is a generator named ```breadko``` in this app. You can use it by typing this command:

``` sh
rails g breadko posts contents:string user_id:integer
```
  Then, modify the files to fit your needs.
