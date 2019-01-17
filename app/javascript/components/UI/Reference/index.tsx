import * as ReactDOM from 'react-dom';
import * as React from 'react';

interface Props {
  element: Node
}

class Reference extends React.PureComponent<Props> {
  public render() {
    return (
      <div />
    );
  }

  public componentDidMount() {
    this.use((node, element) => (
      node.appendChild(element)
    ));
  }

  public componentWillUnmount() {
    this.use((node, element) => (
      node.removeChild(element)
    ));
  }

  private use(action: (node: Element | Text, children: Props['element']) => void) {
    const { element } = this.props;
    const node = ReactDOM.findDOMNode(this);
    action(node, element);
  }
}

export default Reference;