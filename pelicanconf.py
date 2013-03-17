#!/usr/bin/env python
# -*- coding: utf-8 -*- #

AUTHOR = u'James Knoblauch'
SITENAME = u'jckno.com'
SITEURL = 'http://jckno.com'

TIMEZONE = 'America/Detroit'

DEFAULT_LANG = u'en'

# Blogroll
LINKS =  (('Pelican', 'http://docs.notmyidea.org/alexis/pelican/'),
          ('Python.org', 'http://python.org'),
          ('Jinja2', 'http://jinja.pocoo.org'),
          ('You can modify those links in your config file', '#'),)

# Social widget
SOCIAL = (('You can add links in your config file', '#'),
          ('Another social link', '#'),)

DEFAULT_PAGINATION = 10

FILES_TO_COPY = (('static/robots.txt', 'robots.txt'),
                 ('static/CNAME', 'CNAME'),)
