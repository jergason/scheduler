# Application settings

#set up datebase information
require "dm-core"
require "dm-aggregates"
#DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV["DATABASE_URL"] || "sqlite:///Users/jergason/Dropbox/prince_lab_stuff/mass_spec_scheduler/scheduler.db")
set :email_recipient, "remucnairomirnoham@gmail.com"
set :email_sender, "scheduler@chem.byu.edu"
set :email_username, ENV["SENDGRID_USERNAME"]
set :email_password, ENV["SENDGRID_PASSWORD"]
set :email_domain, ENV["SENDGRID_DOMAIN"] || "localhost.localdomain"
set :email_smtp_address, ENV["SMTP_ADDRESS"] || "smtp.gmail.com"
set :email_port, "25"
set :calendar_html, <<EOF
<iframe src="http://www.google.com/calendar/embed?src=l4ci6jlgvkm7frsq1vgkiapnso%40group.calendar.google.com&ctz=America/Denver" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>
EOF
