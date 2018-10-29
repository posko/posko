# POS using rails [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/neume/posko/tree/develop)
  A free to use POS app written on rails. It currently targets small-size businesses like 'retail stores', restaurants and others.


[![Build Status](https://travis-ci.org/neume/posko.svg?branch=develop)](https://travis-ci.org/neume/posko)
[![Maintainability](https://api.codeclimate.com/v1/badges/12cd8cf666a27e7c7b10/maintainability)](https://codeclimate.com/github/neume/posko/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/12cd8cf666a27e7c7b10/test_coverage)](https://codeclimate.com/github/neume/posko/test_coverage)

# Demo App
Try it [here](https://posko.herokuapp.com/)

This demo app resets every 6 hours. It is hosted on a free dyno that might not be
available at the moment of your visit. It is also implemented minimally with less to no
proper security measures.

*This app instance is hosted for **DEMO** purposes only and is **NOT MONITORED** actively. Do not
leave any personal information like passwords, email, etc. It is advisable to use
made-up **emails** and **password** for your own safety.*

*The owner of this app will not
be liable for any data breach due to this demo app's lack of proper security
measures.*

# Specs
* Tested on Ruby ``` 2.4.3 ```
* Rails ```5.1.6```

# Setting Up
## First Time
  Run ``` bin/setup ```

## Else (development)
  Run ``` bin/update ```

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
[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/9dfaf1eb5d5768ecaae0)

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
  [Posko Electron](https://github.com/neume/posko-electron) is now on its way. This is the first attempt to bring posko on desktops

# Contributing
  Contributions/Suggestions are very welcome. Check it out [here](https://github.com/neume/posko])

  There is a generator named ```breadko``` in this app. You can use it by typing this command:

``` sh
rails g breadko posts contents:string user_id:integer
```
  Then, modify the files to fit your needs.


# Project 'Raspberry Pi 3 server'
This POS project is being developed to work on mini computers. I don't have yet these physical
devices to test if this approach will actually work. I am partnering with local
store owners to test its capabilities, drawbacks and upkeep once it is fully functional.
But due to the slow development and the lack of hardware, this project maybe out
by late 2019.

If you have a spare device and would like to support this idea, you can send some help. I will gratefully accept a unit of Raspberry Pi 3 from you. ;)

Or you can initiate and work on this project yourself and share your experience with us
