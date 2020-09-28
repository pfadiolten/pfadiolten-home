import * as React from 'react';
import HiddenLink from '../UI/HiddenLink';
import Card from '../UI/Card';
import { CardHeader, CardImg, CardTitle } from 'reactstrap';
import CardOptions from '../UI/Card/Options';

interface Props {
  scout_name: string
  url:        string
  avatar:     string
  children?:  React.Node
}

const User: React.FC<Props> = ({ scout_name, url, avatar, children }) => (
  <HiddenLink href={url}>
    <Card hoverable>
      <CardImg top src={avatar} width="100%" alt={`avatar of ${scout_name}`} />
      <CardHeader className="justify-content-center">
        <CardTitle>
          {scout_name}
        </CardTitle>
        {children && (
          <CardOptions>
            {children}
          </CardOptions>
        )}
      </CardHeader>
    </Card>
  </HiddenLink>
);

export {
  User as default,
  Props as UserProps,
};
