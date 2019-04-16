import * as React from 'react';
import EventRecord from '../../../models/Event';
import { Card, CardBody, CardTitle, Col, Row } from 'reactstrap';
import TimeAndLocation from './TimeAndLocation';
import Html from '../../UI/Html';
import Footer from './Footer';

interface Props {
  event:     EventRecord
  noDate:    boolean
}

class Event extends React.PureComponent<Props> {
  static defaultProps: Partial<Props> = {
    noDate:   false,
  };

  public render() {
    const { noDate, event } = this.props;
    const {
      title,
      kind,
      groups,
      description,
      start_location: startLocation,
      starts_at:      startsAt,
      end_location:   endLocation,
      ends_at:        endsAt,
    } = event;
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
                  {groups.map(({ id, abbreviation, links: { show: groupPath } }) => (
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
                <Html className="trix-content text-left">
                  {description}
                </Html>
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
        <Footer event={event} />
      </Card>
    );
  }
}

export default Event;