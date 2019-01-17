import { Card as BootstrapCard, CardProps } from 'reactstrap';
import * as React from 'react';

interface Props extends CardProps {
  hoverable: boolean
}

const Card: React.FC<Props> = ({ className, hoverable, ...props }) => (
  <BootstrapCard {...props} className={`${className} ${hoverable && 'card--hoverable'}`} />
);

Card.defaultProps = {
  className: '',
  hoverable: false,
};

export default Card;