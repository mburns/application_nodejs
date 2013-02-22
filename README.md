## Description

This cookbook is designed to be able to describe and deploy Node.js web applications using Upstart.

Note that this cookbook provides the Node-specific bindings for the `application` cookbook; you will find general documentation in that cookbook.

## Requirements

Chef 0.10.0 or higher required (for Chef environment use).

Upstart 1.4 or higher for the use of `setuid` in the default Upstart configuration template.
This requirement can be worked around by specifying a custom template.

The following Opscode cookbooks are dependencies:

* [application](https://github.com/opscode-cookbooks/application)
* [nodejs](https://github.com/mdxp/nodejs-cookbook)

## Resources/Providers

The `nodejs` sub-resource LWRP deals with deploying Node.js applications using Upstart. It is not meant to be used by itself; make sure you are familiar with the `application` cookbook before proceeding.

### Attribute Parameters

- **npm**: If `true`, `npm` will be used to install the dependencies specified in `packages.json`. Defaults to `true`.
- **template**: The name of the template that will be used to create the Upstart configuration file. If specified, it will be looked up in the application cookbook. Defaults to `nodejs.upstart.conf.erb` from this cookbook.
- **entry_point**: The argument to pass to node. Defaults to `app.js`.

## Usage

Here is an example hello world application using [Express](http://expressjs.com):

```
application "hello-world" do
  path "/srv/node-hello-world"
  owner "www-data"
  group "www-data"
  packages ["git"]

  repository "git://github.com/visionmedia/express.git"
  
  nodejs do
    entry_point "examples/hello-world"
  end
end
```

## License and Author

Author:: Conrad Kramer (<conrad@kramerapps.com>)

Copyright 2013, Kramer Software Productions, LLC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
