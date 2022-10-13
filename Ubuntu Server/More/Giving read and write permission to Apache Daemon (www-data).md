# GIVING READ AND WRITE PERMISSION TO APACHE'S DAEMON (www-data)
You will see that Apache have a specific user that interact with files and folders.

<br>

Add the `www-data` user to the same group that your user is part. Usually the name of the group in EC2 (from a Ubuntu installation) is `ubuntu`.

```bash
sudo usermod -a -G ubuntu www-data
```

> **IMPORTANT:** Make shure that the folder or file has your user group as its owner.
