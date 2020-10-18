# dairymanagement

Flutter Project for Database management


# This project is not standalone! Why?
## Living on the edge
<p> Flutter web is currently in beta and does not support MySql plugins as of 30th September 2020. So, I've written a PHP script that simply takes the query as a string from this project, executes the query and returns the result as a json.</p>

## You could have simply made some APIs in the php script and need not have passed the whole query from this project
<p> Yes you are right, but I've done this way so that, once Flutter web begins supporting MySQL plugins, I can simply remove the http requests and use the queries directly without the need for a php server</p>