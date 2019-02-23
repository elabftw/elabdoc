## PHP configuration

All of the steps below are optional, **eLabFTW** will work fine without all of that. But if you wish to make your install more secure, and if you know what you are doing, you should modify a few config files, as shown below.

### Sessions

We don't want the PHP sessions stored in `/tmp`. So let's put them in a folder where only the webserver can get access. In your `php.ini`:

~~~ini
session.cookie_httponly = true
session.cookie_secure = true
session.use_strict_mode = true
session.save_path = /path/to/sessions-folder
session.sid_length = 42
~~~

Now create the folder to store sessions:

~~~bash
mkdir -p /path/to/sessions-folder
# make the webserver user own it
# this would be www-data on most Apache systems
chown nginx:nginx /path/to/sessions-folder
# tighten the permissions
chmod 700 /path/to/sessions-folder
~~~

### PHP-FPM configuration

If you use PHP-FPM, change the config like this:

~~~ini
expose_php = Off
~~~

### Other configuration

Here it is assumed that **eLabFTW** is installed at `/elabftw`, adapt the paths for your case.

~~~ini
# this will make elabftw faster
opcache.enable = 1
# disable opening URL with fopen()
allow_url_fopen = Off
# enable open_basedir to restrict PHP's ability to read files
open_basedir = /elabftw/:/tmp/
# disable functions that could be dangerous
disable_functions = php_uname, getmyuid, getmypid, passthru, leak, listen, diskfreespace, tmpfile, link, ignore_user_abord, shell_exec, dl, system, highlight_file, source, show_source, fpaththru, virtual, posix_ctermid, posix_getcwd, posix_getegid, posix_geteuid, posix_getgid, posix_getgrgid, posix_getgrnam, posix_getgroups, posix_getlogin, posix_getpgid, posix_getpgrp, posix_getpid, posix_getppid, posix_getpwnam, posix_getpwuid, posix_getrlimit, posix_getsid, posix_getuid, posix_isatty, posix_kill, posix_mkfifo, posix_setegid, posix_seteuid, posix_setgid, posix_setpgid, posix_setsid, posix_setuid, posix_times, posix_ttyname, posix_uname, phpinfo
~~~

### File permissions

Prevent access to uploaded files and cached files:

~~~bash
chown nginx:nginx /elabftw/uploads /elabftw/cache
chmod 700 /elabftw/uploads /elabftw/cache
~~~

Same with config file:

~~~bash
chown nginx:nginx /elabftw/config.php
chmod 600 /elabftw/config.php
~~~
