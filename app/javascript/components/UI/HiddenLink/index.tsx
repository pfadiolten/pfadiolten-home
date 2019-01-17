import * as React from 'react';

interface Props {
  href:      string
  children?: React.Node
}

class HiddenLink extends React.PureComponent<Props> {
  public render() {
    const { ...restProps } = this.props;
    return <a {...restProps} className="unstyle" />;
  }
}

export default HiddenLink;