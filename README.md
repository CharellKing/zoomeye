# rb_zoomeye

zoomeye api for ruby.

## Install
``` bash
gem install zoomeye
```

## Reference

As the official website, the interfaces provided encapsulation are below:

+ login

login with username and password, get an access token. for the details, please read the official api doc:
[https://www.zoomeye.org/api/doc#user](https://www.zoomeye.org/api/doc#user)

+ resouces_info

get resources info for account. for the details, please read the official api doc:

[https://www.zoomeye.org/api/doc#resources-info](https://www.zoomeye.org/api/doc#resources-info)

+ host_search

search the host devices. for the details, please read the official api doc:

[https://www.zoomeye.org/api/doc#host-search](https://www.zoomeye.org/api/doc#host-search)


+ web_search

search the web technologies. for the details, please read the official api doc:

[https://www.zoomeye.org/api/doc#web-search] (https://www.zoomeye.org/api/doc#web-search)

**normally, a dict type is returned when call all above apis, except the 'login' api.**


## 异常捕获

``` ruby
class ZoomEyeError < StandardError
  attr_reader :code, :desc
  def initialize(code, desc)
    @code = code      # string: http status code
    @desc = desc      # string: http message
  end

  # return exceptial mesesage.
  def message
    "[#{@code}]#{@desc}"
  end
end

```

## Example

``` ruby
#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-
require 'zoomeye'

if __FILE__ == $0
  begin
    ze = ZoomEye.new(("foo@bar.com", "foopass")
    ze.login
    puts ze.resources
    puts ze.host_search("port:80", 7, "app,device")
    puts ze.web_search("port:21", 1, "webapp,os")
  rescue => e
    puts e.message
  end
end
```
