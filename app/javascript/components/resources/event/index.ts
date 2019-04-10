
interface Event {
  id:    string
  title: string
  starts_at: string
  start_location: string
  ends_at: string
  end_location: string
  url: string
  groups: {
    name: string,
  }[]
}

export default Event;