import * as React from 'react';
import { default as ReactCalendar } from 'react-calendar';

interface Props {
  date:     Date
  onChange: (Date) => void
}

class Calendar extends React.PureComponent<Props> {
  public render() {
    const { date, onChange } = this.props;
    return (
      <ReactCalendar
        value={date}
        locale="de-CH"
        onChange={onChange}
      />
    );
  }
}

export default Calendar;