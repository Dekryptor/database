BlackEye
========
The best DarkOrbit private server.

Project Structure
-----------------
BlackEye is divided in 3 main components:
 * The CMS
 * The emulator
 * The database

### The CMS

The CMS is the website that the user will visit in order to play BlackEye.<br/>
The source is written in PHP 7.0 on top of the [Alexya Framework](https://github.com/manulaiko/alexya)
and is located on repository *[cms](https://github.com/BlackEyePS/cms)*

For more information about the CMS read the *README.md* file on *cms* repository.

### The emulator
The emulator is the server that handles *ingame* connections.
The source is written in Java 8 on top of the [Tabitha Framework](https://github.com/manulaiko/tabitha)
and is located on repository *[emulator](https://github.com/BlackEyePS/emulator)*

For more information about the emulator read the *README.md* file on *emulator* repository.

### The database
The database contains the data that will be used by the CMS and the emulator.<br/>
It's the file *database.sql* located on branch *master*.

Contributing to BlackEye
------------------------
If you want to contribute to this project you're free to start a pull request.
But before you start spamming with pull request keep this in mind:
 * Source **must** be commented, it doesn't need to be a extremely detailed but something clean and concise
 * Keep a standard coding style, beauty code is a priority, try to follow the style of the rest of the project (and use spaces instead of tabs)
