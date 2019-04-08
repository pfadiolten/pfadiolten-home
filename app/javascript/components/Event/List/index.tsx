import * as React from 'react';
import { Col, Row } from 'reactstrap';
import Calendar from '../../UI/Calendar';
import * as queryString from 'query-string';

interface Props {
  apiUrl: string
}

interface State {
  date: Date
}

class EventList extends React.PureComponent<Props, State> {
  public state = {
    date: EventList.getSelectedDate(),
  };

  public render() {
    const { date } = this.state;
    return (
       <Row noGutters>
         <Col md={6} lg={4} xl={3}>
           <Calendar date={date} onChange={this.onDateChange} />
         </Col>
         <Col>
            right
         </Col>
       </Row>
    );
  }

  private onDateChange = (date: Date) => {
    this.setState({
      date,
    });
    if (window.history.replaceState) {
      const searchQuery = queryString.stringify({
        ...queryString.parse(location.search),
        date: `${date.getFullYear()}.${date.getMonth() + 1}.${date.getDate()}`,
      });
      const newLocation =
        `${window.location.protocol}//${window.location.host}${window.location.pathname}`
        + `?${searchQuery}`;
      window.history.replaceState({}, '', newLocation);
    }
  };

  static getSelectedDate = () => {
    const { date } = queryString.parse(location.search);
    if (date != null && typeof date === 'string') {
      const dateParts = date.split('.');
      if (dateParts.length === 3) {
        const p = dateParts as any as number[];
        return new Date(p[0], p[1] - 1, p[2]);
      }
    }
    return new Date();
  };
}

export default EventList;