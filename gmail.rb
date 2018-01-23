require 'gmail'
require "google_drive"
require 'spreadsheet'
require 'pry'
require_relative 'mairie.rb'
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
my_hash = get_all_the_urls_of_nord

#Définition de la fonction pour envoyer un mail unique avec comme paramètre une mairie et un email
def send_email_to_line(mairie, email)
  gmail = Gmail.connect("xxxx", "xxxx")
	#puts "Fonction ok" if gmail.logged_in?
  gmail.deliver do 
    to email[1..100]
    subject "Bonjour de la part de THP"
    html_part do
      content_type 'text/html; charset=UTF-8'
      body my_html(mairie) #référence au html dans le même dossier
	end
  end
end


#send_email_to_line("seb", "sebastien.rombaut@hotmail.fr")

#Méthode pour envoyer un email à chaque ligne du spreadsheet
def go_through_all_the_lines(spreadsheet)
  ws = spreadsheet
  for i in (2..ws.num_rows) #ws.num_rows permet de balayer tout le spreadsheet
  	send_email_to_line(ws[i,1], ws[i,2])
  end

end

#Méthode pour créer une spreadsheet à partir d'un hash
def spreadsheet_creation(hash_input)
  session = GoogleDrive::Session.from_config("config.json")
  spreadsheet = session.create_spreadsheet(title = 'hash_THP')
  ws = spreadsheet.worksheets[0]
  ws[1,1] = "Prénom"
  ws[1,2] = "Mail"
  i = 2
  hash_input.each do |key, value|
    ws[i, 1] = key
	ws[i, 2] = value
	i +=1
  end
ws.save
ws
end
#spreadsheet_creation(my_hash)
#appelle de la grosse fonction pour lancer la machine ! 
go_through_all_the_lines(spreadsheet_creation(my_hash))

