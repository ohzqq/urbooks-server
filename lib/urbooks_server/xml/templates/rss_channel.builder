#!/usr/bin/env ruby

xml.instruct!(:xml, :version=>"1.0", :encoding=>"utf-8")

xml.tag!(
  :rss,
  version: "2.0",
  "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",
  "xmlns:atom" => "http://www.w3.org/2005/Atom"
) do |rss|
  rss.tag!(:channel) do |channel|
    channel.tag!(:title, title)
    channel.tag!(:link, url)
    channel.tag!(:language, language)
    channel.tag!(:description, description)
    channel.tag!(:cover, cover)
    channel.tag!(:category, "Books")
    books.meta.each do |book|
      channel.tag!(:item) do |item|
        render "rss_item", book, xml: item
      end
    end
  end
end
