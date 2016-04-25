#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-

module Zoomeye
  class ZoomEyeError < StandardError
    attr_reader :code, :desc
    def initialize(code, desc)
      @code = code
      @desc = desc
    end

    def message
      "[#{@code}]#{@desc}"
    end
  end
end
