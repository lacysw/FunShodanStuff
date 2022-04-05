# FunShodanStuff

A collection of interesting automation scripts to use with Shodan. Requires a free Shodan API key.

Disclaimer: I am not responsible for the end use of any code contained within this repository.

## Find WordPress Installers

Queries Shodan for webpages with `/wp-admin/wp-install.php` accessible. Opens all results in Firefox tabs for quick viewing. Example:

![Support for executing arbitraty non-interactive commands.](/screenshots/findWordPressInstallers.sh.png)

### Execution

1. Run `./findWordPressInstallers.sh`
2. Run the output file 

### Dependancies:

 - Shodan CLI initialized with API key
 - Bash + standard utils
 - Firefox in `$PATH`
