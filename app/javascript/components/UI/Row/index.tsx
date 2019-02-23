import * as React from 'react';
import { Row as BootstrapRow, RowProps } from 'reactstrap';

interface Props extends RowProps {

}

const Row: React.FC<Props> = <T, >({ ...props }) => {
  class RowComponent extends BootstrapRow<{}> {}
  return (
    <RowComponent {...props} />
  );
};

export default Row;