["book_inventory", "book_management", "book_website"].each do |app|
  yum_package app do
    action :remove
  end
end

v = ENV['GO_DEPENDENCY_LABEL_INVENTORY_PIPELINE'][4..-1]
remote_file "/tmp/book_inventory-#{v}-rpm.rpm" do
  source "http://nexus-server:8081/nexus/content/repositories/releases/com/thoughtworks/studios/go/book_inventory/#{v}/book_inventory-#{v}-rpm.rpm"
end

yum_package "book_inventory" do
  action :install
  source "/tmp/book_inventory-#{v}-rpm.rpm"
end

v = ENV['GO_DEPENDENCY_LABEL_CATALOG_PIPELINE'][4..-1]
remote_file "/tmp/book_management-#{v}-rpm.rpm" do
  source "http://nexus-server:8081/nexus/content/repositories/releases/com/thoughtworks/studios/go/book_management/#{v}/book_management-#{v}-rpm.rpm"
end

yum_package "book_management" do
  action :install
  source "/tmp/book_management-#{v}-rpm.rpm"
end

v = ENV['GO_DEPENDENCY_LABEL_WEBSITE_PIPELINE'][5..-1]
remote_file "/tmp/book_website-#{v}-rpm.rpm" do
  source "http://nexus-server:8081/nexus/content/repositories/releases/com/thoughtworks/studios/go/book_website/#{v}/book_website-#{v}-rpm.rpm"
end

yum_package "book_website" do
  action :install
  source "/tmp/book_website-#{v}-rpm.rpm"
end

execute "remove rpms" do
  command "rm /tmp/*.rpm"
end
