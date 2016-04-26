#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-
require 'net/http'
require 'json'
require "zoomeye/version"

require File.dirname(__FILE__) + '/zoomeye_error.rb'

module Zoomeye
  class ZoomEye
    @@home_url = "http://api.zoomeye.org"
    @@login_sub_url = "/user/login"
    @@resource_sub_url = "/resources-info"
    @@host_sub_url = "/host/search"
    @@web_sub_url = "/web/search"

    attr_reader :user
    def initialize(user, pass)
      @user = user
      @pass = pass
      @token = nil
    end

    def post(url, params)
      json_headers = {"Content-Type" => 'application/json',
                      "Accpet" => 'application/json'}
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      return http.post(uri.path, params.to_json, json_headers)
    end

    def path_with_params(uri, params)
      if params.length > 0
        param_list = []
        params.each do |key, val|
          param_list.push("#{key}=#{val}")
        end
        return [uri, param_list.join("&")].join("?")
      end
      return uri
    end

    def get(uri, params)
      full_path = path_with_params(uri, params)
      uri = URI.parse(full_path)
      http = Net::HTTP.new(uri.host, uri.port)
      auth = "JWT " + @token
      return http.get(full_path, {'Authorization' => auth})
    end

    def login
      res = post(@@home_url + @@login_sub_url, {"username" => @user, "password" => @pass})
      body = JSON.parse res.body
      if '200' == res.code
        @token = body['access_token']
      else
        raise ZoomEyeError.new(res.code, body["message"])
      end
    end

    def resources_info
      res = get(@@home_url + @@resource_sub_url, {})
      body = JSON.parse res.body
      if '200' == res.code
        return body
      else
        raise ZoomEyeError.new(res.code, body["message"])
      end
    end

    def host_search(query, page=nil, facets=nil)
      params = {}
      params["query"] = query if query
      params["page"] = page if page
      params["facets"] = facets if facets
      res = get(@@home_url + @@host_sub_url, params)
      body = JSON.parse res.body
      if '200' == res.code
        return body
      else
        raise ZoomEyeError.new(res.code, body["message"])
      end
    end

    def web_search(query, page=1, facets=nil)
      params = {}
      params["query"] = query if query
      params["page"] = page if page
      params["facets"] = facets if facets
      res = get(@@home_url + @@web_sub_url, params)
      body = JSON.parse res.body
      if '200' == res.code
        return body
      else
        raise ZoomEyeError.new(res.code, body["message"])
      end
    end
  end
end
