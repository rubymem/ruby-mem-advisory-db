# Ruby Leaky Gems Database

The [RubyMem](https://www.rubymem.com) Database is a community effort to compile all known memory leaks that are relevant to Ruby gems.

You can check your own Gemfile.locks against this database by using [bundler-leak](https://github.com/rubymem/bundler-leak).

## Support Our RubyMem Initiative!

This project has been a community effort since the beginning. The more reports we track, the more value we can provide to your future projects!

### How You Can Help

Do you know about a known memory leak that isn't [listed in this database](https://www.rubymem.com/advisories)? Open an issue, submit a PR, or [use this form](https://rubymem.com/advisories/new) which will email the maintainers.

## Directory Structure

The database is a list of directories that match the names of Ruby libraries on
[rubygems.org]. Within each directory are one or more files
for the Ruby library. These files can be named however you want, in this example it is named after the PR number in github.

    gems/:
      celluloid/:
        612.yml


## Format

Each file contains the information in [YAML] format:

```yaml
---
gem: celluloid
url: https://github.com/celluloid/celluloid/issues/670
title: Memory Leak using Celluloid::Future
date: 2015-08-31
description: |
  The Celluloid::Group::Spawner appears to never clean up the completed Threads
  that it creates.
leaky_versions:
  - "> 0.16.0, < 0.17.2"
patched_versions:
  - ">= 0.17.3"
```

### Schema

* `gem` \[String\]: Name of the affected gem.
* `framework` \[String\] (optional): Name of the framework which the affected
  gem belongs to.
* `platform` \[String\] (optional): If this vulnerability is platform-specific, name of platform this vulnerability affects (e.g. jruby)
* `url` \[String\]: The URL to the full advisory.
* `title` \[String\]: The title of the advisory or individual vulnerability.
* `date` \[Date\]: The public disclosure date of the advisory.
* `description` \[String\]: One or more paragraphs describing the vulnerability.
* `leaky_versions` \[String\]: The version requirement of the gem with a known memory leak.
* `unaffected_versions` \[Array\<String\>\] (optional): The version requirements for the
  unaffected versions of the Ruby library.
* `patched_versions` \[Array\<String\>\]: The version requirements for the
  patched versions of the Ruby library.

## Tests

Prior to submitting a pull request, run the tests:

```
bundle install
bundle exec rspec
```

## Credits

Please see [CONTRIBUTORS.md].

[rubygems.org]: https://rubygems.org/
[YAML]: http://www.yaml.org/
[CONTRIBUTORS.md]: https://github.com/rubymem/ruby-mem-advisory-db/blob/master/CONTRIBUTORS.md
