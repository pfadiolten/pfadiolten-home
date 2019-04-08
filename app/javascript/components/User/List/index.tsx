import * as React from 'react';
import { Col, Row } from 'reactstrap';
import User, { UserProps } from '../';

interface Props {
  users: UserProps[]
}

const UserList: React.FC<Props> = ({ users }) => (
  <Row className="row-cards row-deck justify-content-center">
      {users.map((user) => (
        <Col xs={6} md={4} lg={3} key={user.scout_name}>
          <User {...user} />
        </Col>
      ))}
  </Row>
);

export default UserList;