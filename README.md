# password-manager
Web Based Password Manager


### How to set up
1. clone repo (`git clone https://github.com/password-manager/password-manager.git`)
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

###Sharing access

Why I didn't use one password to encrypt all passwords for sharing?

It (password) would have to be kept somewhere and accesses from within the application so if someone gets access to the server he would have both all encrypted passwords and a password to decrypt them.

What I used instead?

For each entry I'm generating a token based on a user's master password (so that breaking into system won't reveal all passwords) and id (so that token is unique for each entry) and using this token together with a new salt I'm encrypting password that can be later decrypted with shared token.
Then I merged the token with generated timestamp and encrypted (with password and salt ) to prevent changing the timestamp


Another remarks
If the application hasn't been launched already it would make more sense to save both passwords while creating an entry, but with already running application that's not possible as some records already exist and we are not able to compute sharing passwords for them (without having users to enter their master passwords).
