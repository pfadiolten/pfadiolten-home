import * as React from 'react';
import { Row } from 'reactstrap';
import './index.scss';

interface Props<T> {
  of:         T[]
  className?: string
  children:   (T) => React.Node
}

class RowList<T> extends React.PureComponent<Props<T>> {
  public render() {
    const { of: elements, className, children } = this.props;
    return (
      // TODO: everything after `row--list` should be merged into a single css class
      <Row className={`row-deck row--list justify-content-md-center justify-content-lg-start flex-nowrap flex-md-wrap ${className}`}>
        {elements.map(children)}
      </Row>
    );
  }
}

export default RowList;