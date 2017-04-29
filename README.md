# garfield-daily-strip-mailer
Grabs daily strip and if e-mail is provided - sends it using shell mail command

```
$ ./garfield.sh user@domain.com
```

Run it daily with cron: `crontab -e`:
```
00 13 * * * /path/to/scrip/garfield.sh user@domain.com
```
