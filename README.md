[![Build Status](https://travis-ci.org/jacktams/ConnectedDriveAPI.svg?branch=master)](https://travis-ci.org/jacktams/ConnectedDriveAPI)
[![Coverage Status](https://coveralls.io/repos/github/jacktams/ConnectedDriveAPI/badge.svg?branch=master)](https://coveralls.io/github/jacktams/ConnectedDriveAPI?branch=master)

# ConnectedDriveAPI

Work in progress reverse engineering of BMW Connected Drive APIs, focussed on the i3/i8 utilities but generic features should work for 
any vehicle. 

Currently will only work with EU/ECE vehicles, as the endpoint is hardcoded. However, other territories endpoints are listed in client.rb

The library also does not include the client secret used by BMW, and expects it to be provided.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
