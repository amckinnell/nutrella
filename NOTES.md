# Nutrella Developer Notes

Mutant seems to hang when `cache.rb` is subject to mutation. So, choose one file at a time.

## Running Mutant

`mutant --fail-fast --use rspec Nutrella::Command*`

