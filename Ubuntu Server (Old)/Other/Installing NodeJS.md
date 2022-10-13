# INSTALLING NODEJS
Ubuntu's repository uses older versions of NodeJS. Here is a way to install the most up-to-date NodeJS version.

<br>

Run the following command, informing the major version you want to install.

The following command will install the most recent **version 17**, but you can install whatever you want.

```
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt-get install -y nodejs
```
<br>

Now, check if it installed the proper version.
Example:

```bash
node -v
# v17.9.0

npm -v
# 8.5.5
```
