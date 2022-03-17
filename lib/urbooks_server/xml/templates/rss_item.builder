#!/usr/bin/env ruby

xml.tag!(:title, title.join)
xml.tag!(:description, type: "xhtml") {
  xml.text!("Authors: #{authors.to_s}<br/>")
  xml.text!("Narrators: #{narrators.to_s}<br/>")
  xml.text!("Tags: #{tags.to_s}<br/>")
  xml.text!("Description: " << comments.to_s)
}
xml.tag!("itunes:image", href: cover.url)
xml.tag!("itunes:duration", formats.audiobook.duration)
xml.tag!(
  :enclosure,
  url: formats.audiobook.url,
  type: URbooksServer::Helpers.mime_types[formats.audiobook.ext],
  length: formats.audiobook.duration
)
