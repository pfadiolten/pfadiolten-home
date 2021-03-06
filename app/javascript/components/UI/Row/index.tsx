import * as React from 'react';
import { Row as BootstrapRow, RowProps } from 'reactstrap';

interface Props extends RowProps {

}

const Row: React.FC<Props> = <T, >({ ...props }) => {
  return (
    <BootstrapRow {...props} />
  );
};

export default Row;