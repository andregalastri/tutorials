# APPLYING ICONS FOR SPECIFIC EXTENSIONS

I will use my case. I needed to specify the icons to `.aup3` files, because my system was showing default icons to that.

1. Open terminal and get the current mimetype of the file with the following command:
   ```bash
   mimetype "my_file.aup3"
   ```
   It will inform the current mimetype of the file: `application/vnd.sqlite3`.<br><br>
2. Now, as root, create a new XML file in `/usr/share/mime/packages`, for example `application-audacity3.xml`;
3. Enter the following code inside this file:
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
      <mime-type type="application/audacity3">
          <sub-class-of type="application/vnd.sqlite3"/>
          <comment>Audacity 3 File</comment>
          <glob pattern="*.aup"/>
          <glob pattern="*.aup3"/>
      </mime-type>
  </mime-info>
  ```
  * In the `mime-type type` I informed the new mimetype I was creating: `application/audacity3`.
  * In the `sub-class-of type` I informed the current mimetype of the file: `application/vnd.sqlite3`.
  * In the `glob pattern` I informed the extensions that will to be part of this mimetype: `.aup` and another to `.aup3`.
4. Save the file
5. Create new icon files (PNG or SVG). Create it in various sizes, like, 16x16, 24x24, 48x48, 64x64, 128x128 and 256x256.
6. Save the icons naming them as the same of the new mimetype you created. In my case, all icons was named as `application-audacity3.png` (I replaced the `/` to `-`)
7. Copy the icons to the `/usr/share/icons/hicolor/SIZE/mimetypes` folders, where "SIZE" is the size of the icon you created.
8. Run the following commands in terminal:
  ```bash
  sudo update-mime-database /usr/share/mime/
  sudo gtk-update-icon-cache
  ```
9. Reboot you PC.
