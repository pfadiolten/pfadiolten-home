interface Record {
  id: string
  links: {
    show?:    string
    edit?:    string
    destroy?: string,
  }
}

export interface List<T> {
  records: T[]
  links: {
    index?: string
    new?:   string,
  }
}

export default Record;