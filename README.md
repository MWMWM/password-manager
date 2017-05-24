# password-manager
Web Based Password Manager


### How to set up
1. clone repo
2. change directory to app (`cd password-manager`)
3. edit database.yml and .env if You like
4. run the following commands to install necessary gems and populate database
`bundle install`
`rake db:create`
`rake db:migrate`
`rake db:seed`
5. visit http://lvh.me:3000/ to see the results (use the credentials from .env)
6. run `rake test` to check if tests run properly
7. create/edit/destroy/read entries using API
