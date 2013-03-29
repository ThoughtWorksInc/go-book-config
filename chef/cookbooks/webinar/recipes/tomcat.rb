execute "stop tomcat" do
  command "service tomcat stop"
end

execute "remove older webapps" do
  command "rm -rf /usr/share/tomcat-7.0.37/webapps/book_*"
end

v = ENV['GO_DEPENDENCY_LABEL_INVENTORY_PIPELINE'][4..-1]
execute "copy inventory" do
  command "cp /usr/share/godemo/book_inventory-#{v}.war /usr/share/tomcat-7.0.37/webapps/book_inventory.war"
end

v = ENV['GO_DEPENDENCY_LABEL_CATALOG_PIPELINE'][4..-1]
execute "copy catalog" do
  command "cp /usr/share/godemo/book_management-#{v}.war /usr/share/tomcat-7.0.37/webapps/book_management.war"
end

v = ENV['GO_DEPENDENCY_LABEL_WEBSITE_PIPELINE'][5..-1]
execute "copy website" do
  command "cp /usr/share/godemo/book_website-#{v}.war /usr/share/tomcat-7.0.37/webapps/book_website.war"
end

execute "delete log" do
  command "rm -f /usr/share/tomcat-7.0.37/logs/catalina.out"
end

#use init.d to preserve environment - not recommended
execute "start tomcat" do
  command "/etc/init.d/tomcat start"
end

["http://acceptance:8080/book_inventory/stock", "http://acceptance:8080/book_management/books/new", "http://acceptance:8080/book_website/books"].each do |page|
	http_request "" do
	  url page
	  retry_delay 20
	  retries 3
	end
end
