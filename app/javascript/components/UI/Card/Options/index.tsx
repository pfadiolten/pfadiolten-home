import * as React from 'react';

interface Props {
  children: React.Node
}

const CardOptions: React.FC<Props> = ({ children }) => (
  <div className="card-options">
    {children}
  </div>
);

export default CardOptions;