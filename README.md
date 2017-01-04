# Dignus

_"Connecting event organizers and performers"_

This app was conceived as a final project of Ironhack Web Development Bootcamp and the intial version was written in two weeks.

__Web app written in Rails 4 that helps connect two groups of people__

1. Event organizers who might not have contacts to performers or do not have a budget for it
2. Performers who are starting out and do not have exposure or fans

# Features

- Both type of users can sign up and discover each other. Event organizers can create events and invite performers to participate in them. Performers can also search for events and send invitation requests to the organizer's events.

- User profiles can be updated with description and various media. Performers can upload their audio files and embed youtube videos (organizers as well if they wish to promote themselves).

- Event pages are publicly accessible and can be shared anywhere. Performers that accepted invitation are shown on the page as well and any visitor can go and see their profile to check them out. When the event is over both parties can review each other and attach a rating.

- Users of the app can contact each other via email form, your email address is not shown anywhere and is not shared with anyone.

- The app is bilingual, it's available in English and Czech

- Discovery page will list events and users in 100km radius. The user's location can be changed at any time.

- Google Maps API integration makes adding user's or event's location nice and easy. It also automatically fetches location's image map and other information (address, club website).

- Users and events are taggable.

## Setup & deployment

- My live version was deployed on Heroku.

- You need PostgreSQL database in order for the live search to work because it is integrated with [textacular gem](https://github.com/textacular/textacular) that relies on trigram function of the database.

- Mailer needs to be set up with your own credentials, I used [Figaro](https://github.com/laserlemon/figaro).

- The app uses AWS S3 storage with Paperclip. You can configure the credentials for AWS and start using it (development mode uses local storage).

# To-do

- Make it possible for performers to cancel their performances for specific events.

- Add ability for organizers to completely cancel their event(s) and mail out notifications to everyone involved.

- Asynchronous upload for images and audio.

- Image library for users.
