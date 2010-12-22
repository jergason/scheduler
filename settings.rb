# Application settings

#set up datebase information
require "dm-core"
require "dm-aggregates"
#DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV["DATABASE_URL"] || "sqlite:///Users/jergason/Dropbox/prince_lab_stuff/mass_spec_scheduler/scheduler.db")
set :email_recipient, "jergason@gmail.com"
set :email_sender, "scheduler@chem.byu.edu"
set :calendar_html, <<EOF
<iframe src="http://www.google.com/calendar/embed?src=l4ci6jlgvkm7frsq1vgkiapnso%40group.calendar.google.com&ctz=America/Denver" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>
EOF
