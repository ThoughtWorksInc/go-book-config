jetty_home = '/usr/share/jetty-8.1'

execute "remove older webapps" do
  command "rm -rf /usr/share/jetty-8.1/webapps/book_*"
end
#inv-1.0.0-12_cat-1.0.0-12_site-1.0.0-12
allversions = ENV['GO_DEPENDENCY_LABEL_ACCEPTANCE'].split('_')
v = allversions[0][4..-1]
execute "copy inventory" do
  command "cp /usr/share/godemo/book_inventory-#{v}.war #{jetty_home}/webapps/book_inventory.war"
end

v = allversions[1][4..-1]
execute "copy catalog" do
  command "cp /usr/share/godemo/book_management-#{v}.war #{jetty_home}/webapps/book_management.war"
end

v = allversions[2][5..-1]
execute "copy website" do
  command "cp /usr/share/godemo/book_website-#{v}.war #{jetty_home}/webapps/book_website.war"
end

["http://production/book_inventory/stock", "http://production/book_management/books/new"].each do |page|
	http_request "" do
	  url page
	  retry_delay 20
	  retries 3
	end
end
