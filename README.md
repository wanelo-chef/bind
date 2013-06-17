Description
===========
  DNS server and client installation with automatic A record clobbering via nsupdate from clients.  
  CAREFUL! Client updates will destroy old record and overwrite w/o checking, confirming, or anything!
  If you're manually editing, be sure to add a delete line first -- otherwise you get multiple A records!
  Be security-conscious with the key.

Requirements
============
Currently only tested on SmartOS.  Should be possible to run with minimal refactoring on other platforms.


Attributes
==========

Usage
=====
