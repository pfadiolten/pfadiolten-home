import * as React from 'react';
import EventRecord from '../../../models/Event';
import { Card, CardBody, CardTitle, Col, Row } from 'reactstrap';
import TimeAndLocation from './TimeAndLocation';

interface Props {
  event:  EventRecord
  noDate: boolean
}

class Event extends React.PureComponent<Props> {
  static defaultProps: Partial<Props> = {
    noDate: false,
  };

  public render() {
    const { noDate, event: {
      title,
      description,
      kind,
      start_location: startLocation,
      starts_at:      startsAt,
      end_location:   endLocation,
      ends_at:        endsAt,
      groups } } = this.props;
    return (
      <Card>
        <CardBody className="p-3">
          <Row>
            <Col>
              <CardTitle>
                {title}
              </CardTitle>
            </Col>
          </Row>
          {groups.length !== 0 && (
            <Row className="mt-2">
              <Col className="text-center">
                {groups.map(({ id, abbreviation, routes: { show: groupPath } }) => (
                  <a className="tag tag-info mr-1" href={groupPath} key={id}>
                    {abbreviation}
                  </a>
                ))}
              </Col>
            </Row>
          )}
        </CardBody>
        {description && (
          <CardBody className="px-4 py-2 justify-content-center">
            <Row>
              <Col>
                <div className="trix-content">
                  {description}
                </div>
              </Col>
            </Row>
          </CardBody>
        )}
        <CardBody className="px-4 py-2">
          <TimeAndLocation
            title="Beginn"
            timestamp={startsAt}
            location={startLocation}
            kind={kind}
            noDate={noDate}
            orientation="left"
          />
        </CardBody>
        <CardBody className="px-4 py-2">
          <TimeAndLocation
            title="Ende"
            timestamp={endsAt}
            location={endLocation || startLocation}
            kind={kind}
            noDate={noDate}
            orientation="right"
          />
        </CardBody>
      </Card>
    );
  }
}

export default Event;