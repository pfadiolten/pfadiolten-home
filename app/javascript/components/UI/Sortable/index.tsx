import * as React from 'react';
import * as SortableJs from 'sortablejs';

interface Props {
  children: React.Node[]
}

class Sortable extends React.PureComponent<Props> {
  private ref = React.createRef<HTMLDivElement>();
  private element: SortableJs;

  public render() {
    const { children } = this.props;
    return (
      <div ref={this.ref}>
        {children}
      </div>
    );
  }

  public componentDidMount() {
    this.element = SortableJs.create(this.ref.current, {
      animation: 200,
    });
  }

  public componentWillUnmount() {
    this.element.destroy();
  }
}

export default Sortable;