#!/usr/bin/env ruby

xml.tag!(:title, title.join)
xml.tag!(:description, type: "xhtml") {
  xml.text!("Authors: #{authors.to_s}<br/>")
  xml.text!("Narrators: #{narrators.to_s}<br/>")
  xml.text!("Tags: #{tags.to_s}<br/>")
  xml.text!("Description: " << comments.to_s)
}
xml.tag!("itunes:image", href: download(:cover).url)
xml.tag!("itunes:duration", duration.to_s)
xml.tag!(
  :enclosure,
  url: download(:audio).url,
  type: URbooksServer::Helpers.audio_mime_types.values.first,
  length: duration.to_s
)
