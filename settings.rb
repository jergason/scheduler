# Application settings
set :email_recipient, "change-me@example.com"
set :email_sender, "scheduler@example.com"
set :queue_location, "queue.yaml"
set :calendar_html, <<EOF
<iframe src="http://www.google.com/calendar/embed?src=l4ci6jlgvkm7frsq1vgkiapnso%40group.calendar.google.com&ctz=America/Denver" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>"
EOF
