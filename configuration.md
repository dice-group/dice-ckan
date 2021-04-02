# Configuration

Configuration in the web UI.  
Login with user *default* to edit settings.

## Presettings

Two users and passwords are known:

* default (sysadmin)
* dice (user)

## Users

* User default
    * http://localhost:5000/user/edit/default
    * Full name: DICE Admin
    * Email: nomail@example.org
    * [Profile picture](../../raw/dice/images/dice-avatar.png)
* User dice
    * http://localhost:5000/user/edit/dice
    * Full name: DICE
    * Email: nomail@example.org
    * [Profile picture](../../raw/dice/images/dice-avatar.png)

## Organizations

* Organization DICE
    * http://localhost:5000/organization/new
    * Name: DICE
    * URL: .../organization/dice
    * [Image](../../raw/dice/imagesdice-organization.svg)
    * Members
        * http://localhost:5000/organization/members/dice
        * default "DICE Admin", role: Admin
        * dice "DICE", role: Editor

## CKAN config

* http://localhost:5000/ckan-admin/config
* Site Title: DICE datasets
* [Site logo](../../raw/dice/imagessite-logo-dice-datasets.png)
* About:

```
# About

The datasets available here are provided by the DICE group of Paderborn University.

If you have any questions, please contact the respective contact persons or visit our website at [dice-research.org](https://dice-research.org/).
```

* Intro Text:

```
# Welcome to DICE datasets

Information about the DICE group can be found on our website at [dice-research.org](https://dice-research.org/).
```

* Custom CSS:

```css
body { background-color: #006BD9 }

/* header */
.masthead { background-color: #006BD9 }
.account-masthead { background-color: #0456A9 }
.account-masthead .account ul li { border-left-style: none }
.masthead .navigation .nav-pills li.active a { background-color: #003162 }
.masthead .navigation .nav-pills li a:hover { background-color: #003162 }
.masthead .navigation .nav-pills li a:focus { background-color: #003162 }

/* footer */
.site-footer { background-color: #003162 }

/* search startpage */
.homepage .module-search .module-content { background-color: #0453A4 }
.homepage .module-search .tags { background-color: #014790 }
.homepage section.featured.media-overlay { display: none; }
```

* Homepage: Search, introductory area and stats