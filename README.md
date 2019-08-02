# Makers-bnb

MakersBnB specification
=======================

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

Headline specifications
=======================

<!-- - Any signed-up user can list a new space. -->
<!-- - Users can list multiple spaces. -->
<!-- - Users should be able to name their space, provide a short description of the space, and a price per night. -->
<!-- - Users should be able to offer a range of dates where their space is available. -->
<!-- - Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space. -->
- Nights for which a space has already been booked should not be available for users to book that space.
- Until a user has confirmed a booking request, that space can still be booked for that night.

Nice-to-haves
=============

* Users should receive an email whenever one of the following         happens:
- They sign up
- They create a space
- They update a space

* Users should receive a text message to a provided number whenever   one of the following happens:
- A user requests to book their space
- Their request to book a space is confirmed
- Their request to book a space is denied

* A ‘chat’ functionality once a space has been booked, allowing       users whose space-booking request has been confirmed to chat with   the user that owns that space

* Basic payment implementation though Stripe.

# User stories

MVP
===

As a seller,
So I can rent my space out,
I want to list my space on the webpage ✅

As a buyer,
So I can stay somewhere for the night,
I want to be able to see a list of spaces on the site ✅

As a user,
So I can use makers bnb,
I want to register for an account ✅

As a user,
So I can use the website,
I want to be able to log in and out. ✅

As a buyer,
So I can go on mental holiday's
I want to be able to request to book a space for a night ✅

As a seller,
So I can make dollar dollar bills,
I want to be able to approve requests ✅

As a buyer,
So I know I can go on holiday's
I want to find out if my request was approved ✅

As a seller,
So I can control availability,
I want to list dates that my space is available ✅

As a buyer,
So I cannot request an unavailable night,
I don't want to be shown unavailable nights ✅

As a buyer,
So I can view properties that I can book,
I want to list spaces available on the days I can travel ✅

As a buyer,
So I can know whether my request can be made,
I want to see on the calendar what days have already been booked ✅

As a buyer,
So I can see only dates the seller has made available,
I want the calendar to show from the start of available dates to the end

Nice to haves
=============

As a buyer,
So I can request more than one day to book,
I want to be able to specify a range of dates to request

As a buyer,
So I can see how much the stay will cost,
I want to see the total for the days requested

<!-- ✅ -->
