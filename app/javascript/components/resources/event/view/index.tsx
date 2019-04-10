import Event from '../';
import * as React from 'react';

interface Props {
  event: Event
}

class EventView extends React.PureComponent<Props> {
  public render() {
    const { event: { title, description } } = this.props;

  }
}

export default EventView;