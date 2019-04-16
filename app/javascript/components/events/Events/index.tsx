import * as React from 'react';
import { Alert, Button, Col, Row } from 'reactstrap';
import Calendar from '../../UI/Calendar';
import * as queryString from 'query-string';
import ApiRequest from '../../api/request';
import routes from '../../../utils/routes';
import RowList from '../../UI/RowList';
import EventRecord from '../../../models/Event';
import Event from '../Event';

interface Props {

}

interface State {
  date: Date
}

class Events extends React.PureComponent<Props, State> {
  public state = {
    date: Events.selectedDate,
  };

  public render() {
    const { date } = this.state;
    const params = { day: date.getDate(), month: date.getMonth() + 1, year: date.getFullYear() };
    return (
      <Row>
        <Col xs={12} md={3} className="mb-4 mb-md-0">
          <Row className="justify-content-center">
            <Col xs="auto">
              <Calendar date={date} onChange={this.onDateChange} />
            </Col>
          </Row>
        </Col>
        <Col>
          <Row>
            <Col className="text-center">
              <h2>
                {date.toLocaleDateString('de-CH', { day: 'numeric', month: 'long', year: 'numeric' })}
              </h2>
            </Col>
          </Row>
          <Row className="justify-content-center">
            <Col className="text-center">
              <ApiRequest to={routes.events({ format: 'json' })} params={params} key={this.dateString}>
                {(events: EventRecord[], { links }) => (
                  <React.Fragment>
                    {(links.new) && (
                      <Row className="mb-2">
                        <Col xs={12} className="d-flex justify-content-center">
                          <a href={links.new}>
                            <Button color="primary">
                              <i className="fas fa-plus fa-fw" />
                            </Button>
                          </a>
                        </Col>
                      </Row>
                    )}
                    {events.length === 0 ? (
                      <Alert color="info">
                        keine Ereignisse für dieses Datum gefunden
                      </Alert>
                    ) : (
                      <RowList of={events}>
                        {(event) => (
                          <Col xs={10} sm={6} lg={5} xl={4} key={event.id}>
                            <Event event={event} />
                          </Col>
                        )}
                      </RowList>
                    )}
                  </React.Fragment>
                )}
              </ApiRequest>
            </Col>
          </Row>
        </Col>
      </Row>
    );
  }

  public componentDidMount() {
    this.onDateChange(this.state.date);
  }

  private onDateChange = async (date: Date) => {
    this.setState({
      date,
    });

    if (window.history.replaceState) {
      const searchQuery = queryString.stringify({
        ...queryString.parse(location.search),
        date: this.dateString,
      });
      const newLocation =
        `${window.location.protocol}//${window.location.host}${window.location.pathname}`
        + `?${searchQuery}`;
      window.history.replaceState({}, '', newLocation);
    }
  };

  private get dateString() {
    const { date } = this.state;
    return `${date.getFullYear()}.${date.getMonth() + 1}.${date.getDate()}`;
  }

  private static get selectedDate() {
    const { date } = queryString.parse(location.search);
    if (date != null && typeof date === 'string') {
      const dateParts = date.split('.');
      if (dateParts.length === 3) {
        const p = dateParts as any as number[];
        return new Date(p[0], p[1] - 1, p[2]);
      }
    }
    return new Date();
  }
}

export default Events;