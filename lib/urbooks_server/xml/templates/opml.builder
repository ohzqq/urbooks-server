#!/usr/bin/env ruby

xml.instruct!(:xml, :version=>"1.0", :encoding=>"utf-8")

xml.tag!(:opml, version: "2.0") do |opml|
  opml.tag!(:title, title.to_s)
  opml.tag!(:dateCreated, Time.now.to_s)
  render "opml_body", body, xml: opml
end
