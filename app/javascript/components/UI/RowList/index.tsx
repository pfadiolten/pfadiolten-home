import * as React from 'react';
import { Row } from 'reactstrap';
import './index.scss';

interface Props<T> {
  of:       T[]
  children: (T) => React.Node
}

class RowList<T> extends React.PureComponent<Props<T>> {
  public render() {
    const { of: elements, children } = this.props;
    return (
      // TODO: everything after `row--list` should be merged into a single css class
      <Row className="row--list justify-content-md-center justify-content-lg-start flex-nowrap flex-md-wrap">
        {elements.map(children)}
      </Row>
    );
  }
}

export default RowList;