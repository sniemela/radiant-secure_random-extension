Factory.define(:page) do |f|
  f.sequence(:title) { |i| "Cool Page #{i}" }
  f.slug { |a| a.title.downcase.gsub(/[^-a-z0-9~\s\.:;+=_]/, '').gsub(/[\s\.:;=+]+/, '-') }
  f.breadcrumb { |a| a.title }
end