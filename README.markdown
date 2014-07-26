# Hon Later

A small app to send [Dan Hon's newsletter](tinyletter.com/danhon) to your paperlater.

Currently only supports me, as it is using Paperlater aren't really supporting this yet. You can get it going on heroku if you want though.

# To run

If you know how to get the bookmarklet key, then you're good to go. Simply run `PAPERLATER_KEY=yourkey rake update` regularly

# For heroku

```
heroku create
git push heroku master
heroku config:set PAPERLATER_KEY=yourkey
heroku run rake db:migrate
heroku addons:add scheduler:standard
heroku addons:open scheduler
```

Then create a daily task to run `rake update`
