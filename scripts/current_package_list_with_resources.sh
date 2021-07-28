#!/bin/sh
#
# Return a list of the site’s datasets (packages) and their resources.
# The list is sorted most-recently-modified first.
#
# API doc: https://docs.ckan.org/en/2.9/api/#ckan.logic.action.get.current_package_list_with_resources
#
# The URL can also be called by a web browser. The returned JSON is formatted e.g. by Firefox.

curl https://ckan.dice-research.org/api/3/action/current_package_list_with_resources > current_package_list_with_resources.txt
