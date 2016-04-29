class MeetingNotification < ActionMailer::Base

  def meeting_request_with_calendar
    event = RiCal.Event do
      description   "MA-6 First US Manned Spaceflight"
      dtstart       DateTime.now.utc
      dtend         (DateTime.now + 1.hour).utc
      location      "Cape Canaveral"
      add_attendee  "jeremy@moz.com"
      organizer     "mozzeru@gmail.com"
    end

    options = {
      'ROLE'     => 'REQ-PARTICIPANT',
      'PARTSTAT' => 'NEEDS-ACTION',
      'RSVP'     => 'TRUE',
      'CN'       => 'Jeremy Modjeska'
    }

    attendee_property = RiCal::PropertyValue::CalAddress.new(
      nil,
      :value  => 'mailto:jeremy@moz.com',
      :params => options
    )

    event.attendee_property = attendee_property

    # Add .ics as an attachment
    mail.attachments['appointment.ics'] = {
      content_type: "text/calendar; charset=UTF-8; method=REQUEST",
      mime_type:    'text/calendar',
      content:      event.export()
    }

    mail(
      :to      => 'jeremy@moz.com',
      :subject => "Calendar event!",
      :from    => "mozzeru@gmail.com"
    )
  end







    # # Generate calendar invite
    # ical = Icalendar::Calendar.new

    # # ical.timezone.tzid = "UTC"
    # e = Icalendar::Event.new

    # # Start / End Time
    # e.dtstart = DateTime.now.utc
    # e.dtend = (DateTime.now + 1.hour).utc

    # # Organizer
    # e.organizer = 'CN=Foo:mailto:mozzeru@gmail.com'

    # # UID
    # e.uid = '8f5a0777-bf6d-17d2-f14a-52e7feedf811'

    # # Created
    # e.append_custom_property('CREATED', 'CREATED:20160420T004438Z')

    # # Description
    # e.description = "Test Event"

    # # Summary
    # e.summary = 'Mozzer U Meeting'

    # # Attendee data
    # attendee_params = {
    #   cytype:       "INDIVIDUAL",
    #   role:         "REQ-PARTICIPANT",
    #   partstat:     "NEEDS-ACTION",
    #   rsvp:         "TRUE",
    #   cn:           "Firstname Lastname",
    #   x_num_guests: "0"
    # }
    # attendee_value = Icalendar::Values::Text.new("MAILTO:jeremy@moz.com", attendee_params)
    # e.append_custom_property("ATTENDEE", attendee_value)

    # ical.add_event(e)

    # # Append custom properties
    # ical.append_custom_property('METHOD', 'REQUEST')

    # # Add .ics as an attachment
    # mail.attachments['appointment.ics'] = {
    #   content_type: "text/calendar; charset=UTF-8; method=REQUEST",
    #   mime_type: 'text/calendar',
    #   content: ical.to_ical
    # }

    # # Generate the mail
    # mail(
    #   to:           'jeremy@moz.com',
    #   subject:      'Mozzer U Test',
    #   from:         'mozzeru@gmail.com'
    # )
  # end
end
