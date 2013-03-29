["root", "go"].each do |user|
	group "tomcat" do
	  action :modify
	  members user
	  append true
	end
end

execute "nexus-yum-conf" do
  command "cp /var/chef/webinar/config/maven/nexus-yum.repo /etc/yum.repos.d"
  umask 644
end
