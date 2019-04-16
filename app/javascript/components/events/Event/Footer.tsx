import * as React from 'react';
import EventRecord, { event } from '../../../models/Event';
import { CardFooter, Col, Row } from 'reactstrap';
import Mail from '../../UI/Mail';

interface Props {
  event: EventRecord
}

const Footer: React.FC<Props> = ({ event: record }) => {
  const { links, user_in_charge: userInCharge } = record;

  return (
    <CardFooter className="p-0">
      <Row>
        <Col className="btn-group">
          {links.edit && (
            <a href={links.edit} className="btn btn-primary col-2 order-3">
              <i className="fas fa-edit fa-fw" />
            </a>
          )}
          {event.hasEnded(record) ? (
            <>
              {renderMail(record)}
              {userInCharge && (
                <a href={userInCharge.links.show} className="btn btn-white col-5 text-left">
                  bei {userInCharge.scout_name}
                </a>
              )}
            </>
          ) : (
            <div className="col" />
          )}
        </Col>
      </Row>
    </CardFooter>
  );
};

const renderMail = ({ title, groups, starts_at: startsAt, user_in_charge: userInCharge }: EventRecord) => {
  const groupString = groups.map((group) => group.abbreviation).join(', ');
  const date = new Date(startsAt * 1000);

  const [ receiver, greeting ] = userInCharge ? (
    [ userInCharge.scout_name, `Liebe/r ${userInCharge.scout_name}` ]
  ) : (
    [ 'info', 'Hallo Zusammen' ]
  );

  const subject = `[Pfadi Olten] Abmeldung für "${title}" (${groupString}) vom ${date.getDate()}.${date.getMonth()}`;
  const body    = `${greeting}\n\nIch kann leider nicht kommen, weil {GRUND}.\n\nLiebe Pfadigrüsse\n{PFADINAME}`;
  return (
    <Mail to={receiver.toLowerCase()} className="btn btn-danger col" {...{ subject, body }}>
      Abmelden
    </Mail>
  );
};

export default Footer;