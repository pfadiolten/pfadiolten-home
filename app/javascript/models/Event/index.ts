import Record from '../Record';

interface EventRecord extends Record {
  title:           string
  kind:            EventKind,
  description?:    string
  starts_at:       number
  start_location:  string
  ends_at:         number
  end_location?:   string
  user_in_charge?: Record & {
    scout_name: string,
  }
  groups: (Record & {
    name:         string
    abbreviation: string,
  })[]
}

type EventKind =
  | 'activity'
  | 'camp'
  | 'holidays'
  | 'other'
;

export default EventRecord;