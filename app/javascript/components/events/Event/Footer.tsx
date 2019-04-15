import * as React from 'react';
import EventRecord from '../../../models/Event';
import { CardFooter, Col, Row } from 'reactstrap';

interface Props {
  event: EventRecord
}

const Footer: React.FC<Props> = ({ event }) => {
  const { user_in_charge: userInCharge, links } = event;

  return (
    <CardFooter className="p-0">
      <Row>
        <Col className="btn-group">
          {links.edit && (
            <a href={links.edit} className="btn btn-primary col-2 order-3">
              <i className="fas fa-edit fa-fw" />
            </a>
          )}
          {userInCharge ? (

          ) : (

          )}
        </Col>
      </Row>
    </CardFooter>
  );
};

const renderMail = ({ title, groups, starts_at: startsAt }: EventRecord) => {
  const groupString = groups.map((group) => group.abbreviation).join('.');
  const { getDate: day, getMonth: month, getFullYear: year } = new Date(startsAt * 1000);
  const subject = `[Pfadi Olten] Abmeldung für "${title}" (${groupString}) vom ${day()}.${month}`;
};

export default Footer;