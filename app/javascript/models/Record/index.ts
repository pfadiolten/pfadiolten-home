interface Record {
  id: string
  routes: {
    show?:    string
    edit?:    string
    destroy?: string,
  }
}

export interface List<T> {
  records: T[]
  routes: {
    index?: string
    new?:   string,
  }
}

export default Record;