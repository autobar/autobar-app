# autobar-app
This repository holds the code for the Ruby on Rails app for the AutoBar.

Some setup must be done in order to get the app's functionality up and running.

- Clone the repository into an aws instance w/ ruby and rails all set. (Defaults should be okay!)
- Make sure that Postgresql is primed.
  ```
    sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
  ```
  ```
    sudo service postgresql initdb
  ```
  ```
    sudo service postgresql start
  ```
- `cd` into the project directory and do the usual ruby setup.
  ```
    bundle install
  ```
- Create a super user account for ec2-user (_ignore the directory errors_)
  ```
    sudo -u postgres createuser -s ec2-user
  ```
  ```
    sudo -u postgres createdb ec2-user
  ```
  ```
    sudo su postgres
    psql
    ALTER USER "ec2-user" WITH SUPERUSER;
    \q
    exit
  ```
 - You should be good to go to run `rails server`!

## Enabling Twilio Services
- Create a Twilio account
- Grab your new Twilio number and in the console run:
  ```
  export TWILIO_ACCOUNT_SID=[YOUR_INFO]
  export TWILIO_AUTH_TOKEN=[YOUR_INFO]
  export TWILIO_PHONE_NUMBER=[YOUR_INFO]
  ```
- Twilio should now work smoothly!

## Payload Structure for Order Information
- Example:
```
  [
    {
      "drivers_license": string,
      "phone_number": string,
      "name":string
    },
    {
      "coke": double,
      "rum": double
    },
    {
      "vodka": double,
      "tonic water": double
    },
    ... Rest of drinks
  ]
```
