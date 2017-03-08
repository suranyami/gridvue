Login into aws ecr

```bash
aws ecr get-login --region us-east-1
$(aws ecr get-login --region us-east-1)
```

Alternatively paste this in your crontab
```bash
@hourly env PATH=/usr/local/bin:$PATH bash -c '$(aws ecr get-login)' > /dev/null 2>&1
```
