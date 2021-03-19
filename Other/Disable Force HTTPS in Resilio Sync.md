
# ENABLE AUTOLOGIN 

In terminal:
```bash
sudo nano /etc/resilio-sync/config.json
```

<br>

The file will be like this
```json
{
    "storage_path" : "/var/lib/resilio-sync/",
    "pid_file" : "/var/run/resilio-sync/sync.pid",

    "webui" :
    {
        "force_https": true,
        "listen" : "127.0.0.1:8888"
    }
}
```

<br>

Change the `"force_https"` parameter to **`false`**. Save (`CTRL+O`) and exit (`CTRL+X`)

<br>

Now, restart Resilio Sync
```bash
sudo service resilio-sync restart
```

<br>

> **IMPORTANT**:<br>
> If the address **localhost:8888** stops working, clear the browser cache and try to force it to access without *https*.
