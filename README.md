# Makers-bnb

MakersBnB specification
=======================

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

Headline specifications
=======================

- Any signed-up user can list a new space.
<!-- - Users can list multiple spaces. -->
<!-- - Users should be able to name their space, provide a short           description of the space, and a price per night. -->
- Users should be able to offer a range of dates where their space    is available.
- Any signed-up user can request to hire any space for one night,     and this should be approved by the user that owns that space.
- Nights for which a space has already been booked should not be      available for users to book that space.
- Until a user has confirmed a booking request, that space can        still be booked for that night.

Nice-to-haves
=============

* Users should receive an email whenever one of the following         happens:
- They sign up
- They create a space
- They update a space
* A user requests to book their space
* They confirm a request
* They request to book a space
* Their request to book a space is confirmed
* Their request to book a space is denied
* Users should receive a text message to a provided number whenever   one of the following happens:
* A user requests to book their space
* Their request to book a space is confirmed
* Their request to book a space is denied
* A ‘chat’ functionality once a space has been booked, allowing       users whose space-booking request has been confirmed to chat with   the user that owns that space
* Basic payment implementation though Stripe.

# User stories

MVP
===

As a user,
So I can rent my space out,
I want to list my space on the webpage

As a user,
So I can stay somewhere for the night,
I want to be able to see a list of spaces on the site

As a user,
So I can use makers bnb,
I want to register for an account

<!-- ✅ -->
