# Changelog

## [1.5.1] - 2024-05-31

### Added

- Added a stream field to the match and segment forms.
- Included streams on the entity management page.
- Displayed streams in all match and segment views.
- Enabled avatar cropping on the user page within the management section.

### Changed

- Updated the avatar crop module (convert into webp format).

## [1.5.0] - 2024-05-28

### Added

- Introduced the "Segment" entity at the same level as matches.
- Included segments on the entity management page.
- Displayed segments in all calendar views.

### Changed

- Renamed several entities:
    - "Tournament" to "Event" (changed everywhere).
    - "Match" to "Segment" (changed only in the calendar column view).
    - "Analytics" to "Analysts" (changed everywhere).
    - "Commentators" to "Casters" (changed everywhere).

## [1.4.3] - 2024-05-13

### Added

- Added a setup field to the match form.
- Included setups on the entity management page.
- Displayed setups in all match views.

## [1.4.2] - 2024-05-01

### Added

- End date of mtch in bots notification

### Changed

- Зossibility to add many backup commentators

## [1.4.1] - 2024-04-22

### Added

- Add host analytic & backup commentator entities

### Changed

- The corporates with incorrect dates are present in the week's display period

## [1.4.0] - 2024-04-05

### Changed

- Move channels into multiple fields
- Invisible match setiing

## [1.1.1] - 2024-01-24

### Fixed

- Cant remove match via soft_destroy
- Wrong showing corporate in date range
- Dont send notification for talents and staff after update match
- Cant update Branding
- Remove user without history still deletes it
- Empty list of deleted disciplines

## [1.1.0] - 2024-01-12

### Added

- Upload calendar data into Excel (Google Docs)
- Cross working hours
- Google Calendar Integration: After user grant acceess to gCalendar
- SVG image upload and passing the right format in response

### Changed

- Cant update match without commentators, analytics, staff_members
- Cross working hours feature takes into accounе matches with isVisible = false


### Fixed

- Corrected an issue with improper user session saving.
- Upload calendar data into Excel (Google Docs) - duplicate tables.
- Show tournaments without end date in list (on create match popup)
- 'One or more commentators have an event scheduled for the specified time.' in edit match popup
- Wrong range of cross working hours
  
## [1.0.1] - 2023-12-11

### Fixed

- Filtering by game discipline

### Added

- Add Tier to Tournament entity

### Changed

- Change response for calendar quarter/year view by including tier
- Remove requirement for fields such as: studio, channel
- Remove whitespace in name and surname columns
- Sorting in alphabetical order
