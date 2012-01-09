#!/usr/bin/ruby
#  Github-flavored markdown to HTML, in a command-line util.
#
#  $ cat README.md | ./ghmarkdown.rb
#
#  Notes:
#
#  You will need to install Pygments for syntax coloring
#
#    $ pip install pygments
#
#  Install the gems rdiscount, albino, and nokogiri
#
#  To work with http://markedapp.com/ I also had to
#    $ sudo ln -s /usr/local/bin/pygmentize /usr/bin
#
require 'rubygems'
require 'rdiscount'
require 'albino'
require 'nokogiri'

def markdown(text)
  options = [:smart,]
  # Replace {% highlight lang [linenos] %}<data>{% endhighlight %} with colourised code.
  text.gsub!(/\{% highlight (.+?) (linenos)? ?%\}(.*?)\{% endhighlight %\}/m) do |match|
    Albino.colorize($3, $1).to_s
  end
  RDiscount.new(text, *options).to_html 
end

puts markdown(ARGF.read)