import * as React from 'react';
import EventRecord from '../../../models/Event';
import { Col, Row } from 'reactstrap';
import LocalizedDate from '../../i18n/Localized/Date';
import LocalizedTime from '../../i18n/Localized/Time';

interface Props {
  title:       string
  timestamp:   number
  location:    string
  kind:        EventRecord['kind']
  noDate:      boolean
  orientation: 'left' | 'right'
}

const TimeAndLocation: React.FC<Props> = ({ title, timestamp, location, kind, noDate, orientation }) => {
  const date    = new Date(timestamp * 1000);
  const noTime  = kind !== 'holidays';
  const isLeft  = orientation === 'left';
  const isRight = !isLeft;

  const margin = isLeft ? 'mr-1' : 'ml-1';

  const timeSymbol = (
    <i className={`fas fa-clock fa-fw ${margin}`} />
  );
  const locationSymbol = (
    <i className={`fas fa-map-marker-alt fa-fw ${margin}`} />
  );
  return (
    <div className={`text-${orientation}`}>
      <Row>
        <Col>
          <h4>
            {title}
          </h4>
        </Col>
      </Row>
      <Row>
        <Col>
          {isLeft && timeSymbol}
          {noDate || (
            <LocalizedDate date={date}/>
          )}
          {(noDate && noTime) || (
            <>,&nbsp;</>
          )}
          {kind !== 'holidays' && (
            <LocalizedTime time={date} />
          )}
          {isRight && timeSymbol}
        </Col>
      </Row>
      <Row>
        <Col>
          {isLeft && locationSymbol}
          {location}
          {isRight && locationSymbol}
        </Col>
      </Row>
    </div>
  )
};

export default TimeAndLocation;