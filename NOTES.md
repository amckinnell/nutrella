# Nutrella Developer Notes

Mutant seems to hang when `cache.rb` is subject for mutation. So, choose one file at a time.

## Running Mutant

`mutant --use rspec Nutrella::Command*`
`mutant --use rspec Nutrella::Cache#lookup`

