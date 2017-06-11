## Timer

Simple Rack app which can show time in UTC.

## Installation
```bash
git clone git@github.com:sovetnik/timer.git
cd /timer
gem install rack
gem install thin
gem install tzinfo
rackup
```
## Usage

After install & rackup, try:
for UTC localhost:8080/time
for UTC & Moscow localhost:8080/time?Moscow
