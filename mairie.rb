require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require'pry'

def get_the_email_of_a_townhal_from_its_webpage(url) 
	page = Nokogiri::HTML(open(url))
	email = page.css('p.Style22')
	email.map do |part|
		part.text if part.text.include?('@')
	end
	#puts email.text if email.text.include?('@')

end

#get_the_email_of_a_townhal_from_its_webpage('http://annuaire-des-mairies.com/95/ableiges.html')

def get_all_the_urls_of_nord
	result = Hash.new
	
	tab_final = []
	page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/nord-2.html'))
	mairie = page.css('a.lientxt')
	mairie.each do |lien|
		ville = lien.text
		email = get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com"+lien['href'][1..100]).compact[0]
		result[ville] = email
		 
	end
	result
end

get_all_the_urls_of_nord
