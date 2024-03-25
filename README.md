# README

Simple support tickets system.

## Features

* Tickets stored in a CSV file first
* Tickets imported from CSV file to DB via `rake tickets:import`
* Tickets can be managed by admin
* Admin can add comments to tickets
* Ticket resolved state can't be applied prior to posting a comment to the ticket
* Tickets view include filtering by fields and statistics
