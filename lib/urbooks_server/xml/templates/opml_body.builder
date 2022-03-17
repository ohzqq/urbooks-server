#!/usr/bin/env ruby

xml.tag!(:body) do |body|
  self.each do |feed|
    body.tag!(:outline, feed)
  end
end
