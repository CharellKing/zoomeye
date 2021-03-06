#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-
require 'zoomeye'

if __FILE__ == $0
  begin
    ze = Zoomeye::ZoomEye.new("foorbar@bar.com", "foobar@pass")
    ze.login
    puts ze.resources_info
    puts ze.host_search("port:80", 7, "app,device")
    puts ze.web_search("port:21", 1, "webapp,os")
  rescue => e
    puts e.message
  end
end
