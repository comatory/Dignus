# Dignus

_Connecting event organizers and performers_

This app was conceived as a final project of Ironhack Web Development Bootcamp and was written in two weeks (as of Dec 5th 2015). Further work will be done on it and it will go live soon.

__Web app written in Rails 4 that helps connect two groups of people__

1. Event organizers who might not have contacts to performers or do not have a budget for it
2. Performers who are starting out and do not have exposure or fans

Both type of users can sign up and discover each other. Event organizers can create events and invite performers to participate in them. Performers can also search for events and send invitation request to the organizer.

User profiles can be updated with description and various media. Performers can upload their audio files and embed youtube videos (organizers as well if they wish to promote themselves).

Event pages are publicly accessible and can be shared anywhere. Performers that accepted invitation are shown on the page as well and any visitor can go and see their profile to check them out. When the event is over both parties can review each other and attach a rating.

Users of the app can contact each other via email form, your email address is not shown anywhere and is not shared with anyone.

## Setup & deployment

- You need PostgreSQL database in order for the live search to work because it is integrated with [textacular gem](https://github.com/textacular/textacular) that relies on trigram function of the database.

- Mailer needs to be set up with your own credentials via [Figaro](https://github.com/laserlemon/figaro).

- You need to set up your own storage for user's media files.
