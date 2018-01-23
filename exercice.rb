require 'gmail'
require "google_drive"
require 'spreadsheet'
require 'pry'
require_relative 'mairie'
require_relative 'get_html.rb'


class WebAgent
 class Cookie < HTTP::Cookie
   def domain
     self.original_domain
   end
 end
end


session = GoogleDrive::Session.from_config("config.json") 
#my_hash = {"Seb" => "sebastien.rombaut@hotmail.fr", "Fanny" => "fannyhenno@gmail.com", "Leila" => "leila_06@hotmail.com", "Fabien" => "robbyro.schelnow@gmail.com"}
my_hash = get_all_the_urls_of_val_doise_townhalls
#gmail = Gmail.connect("rombaut.se", "samura1616")
#puts "Hi" if gmail.logged_in?

=begin
gmail.deliver do
  to "sebastien.rombaut@hotmail.fr"
  subject "Having fun in Puerto Rico!"
  text_part do
    body "Text of plaintext message."
  end
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "<p>Text of <em>html</em> message.</p>"
  end
  
end
=end

=begin
spreadsheet = session.create_spreadsheet(title = 'hash_THP')
ws = spreadsheet.worksheets[0]


ws[1,1] = "Prénom"
ws[1,2] = "Nom"
i = 2

my_hash.each do |key, value|
	ws[i, 1] = key
	ws[i, 2] = value
	i +=1
end
ws.save

#puts gmail.inbox.count(:from => "deffuant@tonsser.com")
#puts gmail.inbox.emails(gm: '"tonsser"')




gmail.inbox.find(:unread).each do |email|
  email.read!
end

gmail.inbox.find(:from => "alice@thefamily.co").each do |email|
  email.delete!
end


n = 2
m = 2
my_hash.each do |key|
gmail.deliver do
  to ws[n,2]
  sujet = "C'est pour oit" + w[m,1]
  subject sujet
  text_part do
    body "Salut trop cool, j'envoie des mails de boloss."
    binding.pry
  end
  #html_part do
  #  content_type 'text/html; charset=UTF-8'
  #  body "<p>Text of <em>html</em> message.</p>"
  #end
  n +=1
  m +=1
 end
end
=end