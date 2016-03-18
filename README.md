# 1password to KeepassX import script

Strongly based on https://github.com/jacobSingh/1pass2keepassx.

## Usage

This script was corrected to use Ruby 2.3.0 and to import csv from 1password 6

```ruby
ruby 1passwordtoKeepassx.rb /path/to/csv > your-file.xml
```

## Import

Keepassx 2.0 is not able to import XML files. You need then import using Keepassx 0.4 and generates a database.
Then import the database into Keepassx 2.0.
