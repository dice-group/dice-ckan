# Configuration

Configuration in the web UI.  
Login with sysadmin user *default* to edit settings.

## Users

* User default
    * http://localhost:5000/user/edit/default
    * Full name: DICE Admin
    * Email: nomail@example.com
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
    * [Image](../../raw/dice/images/dice-organization.svg)
    * Members
        * http://localhost:5000/organization/members/dice
        * default "DICE Admin", role: Admin
        * dice "DICE", role: Editor

## CKAN config

* http://localhost:5000/ckan-admin/config
* Site Title: DICE datasets
* [Site logo](../../raw/dice/images/site-logo-dice-datasets.png)
* About:

```
# About

The datasets available here are provided by the DICE group of Paderborn University.  
If you have any questions, please contact the respective contact persons or visit our website at [dice-research.org](https://dice-research.org/).

## Catalog

Access the catalog metadata structured by the [Data Catalog Vocabulary (DCAT)](https://www.w3.org/TR/vocab-dcat-2/) and various serializations:

* [JSON-LD](/catalog.jsonld)
* [RDF/XML](/catalog.xml)
* [Turtle](/catalog.ttl)

## API

The data can be accessed by the [CKAN API](https://docs.ckan.org/en/2.9/api/). The API returns [JSON](https://www.json.org/) or [JSONP](https://en.wikipedia.org/wiki/JSONP) data. Examples:

* Request all dataset IDs:  
  [/api/3/action/package_list](http://localhost:5000/api/3/action/package_list)
* Request a single dataset:  
  */api/3/action/package_show?id=ID*
* Search:  
  [/api/3/action/package_search?q=dice](/api/3/action/package_search?q=dice)
* Search and return JSONP:  
  [/api/3/action/package_search?q=dice&callback=callbackfunction](/api/3/action/package_search?q=dice&callback=callbackfunction)
```

* Intro Text:

```
# Welcome to DICE datasets

[Explore the available datasets](/dataset/) or have a look at [other access methods](/about).  
Information about the DICE group can be found at [dice-research.org](https://dice-research.org/).
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
.homepage section.featured.media-overlay { display: none }
.homepage .module-content h1 { margin-top: -14px ; margin-bottom: 5px }
.homepage .module-content p { margin-bottom: -5px }
```

* Homepage: Search, introductory area and stats