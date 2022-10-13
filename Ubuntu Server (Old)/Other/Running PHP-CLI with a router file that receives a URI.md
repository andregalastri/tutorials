# RUNNING PHP-CLI WITH A ROUTER FILE THAT RECEIVES A URI
Sometimes we need to run a PHP script in CLI mode using a router file that receives a URI that executes the code.

> **Example:**
> I have a `router.php` that receives the URI from user's request and redirects it to the proper controller file. That controller file will have the command that is needed to be run.
> Lets say that the URI is `/app/route/execute-command` and it needs to be passed as the URI request to the `router.php` file.

To do that, just use the following example:
```bash
# | This is the URI that will be passed to the route.php file.
# |
# |                                    | This calls the PHP. You can specify the absolute path to the PHP binary file.
# |                                    |
# |                                    |    | This is the router file that will receive and resolve the URI.
# v                                    v    v
REQUEST_URI=/app/route/execute-command php "route.php"
```
