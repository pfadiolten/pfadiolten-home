import { Moment } from 'moment';
import * as React from 'react';
import * as DateTime from 'react-datetime';
import { InputProps } from '../index';

interface Props extends InputProps {
  value: string | Date | Moment

  noDate?: boolean
  noTime?: boolean
}

const FORMAT_FOR_DATE = 'DD.MM.YYYY';
const FORMAT_FOR_TIME = 'HH:mm';

const DateTimeInput: React.FC<Props> = ({ value, noTime, noDate, ...inputProps }) => (
  // TODO put a calendar symbol at the end of this
  <DateTime
    defaultValue={value || undefined}
    inputProps={inputProps}

    locale="de"
    dateFormat={!noDate && FORMAT_FOR_DATE}
    timeFormat={!noTime && FORMAT_FOR_TIME}
  />
);

DateTimeInput.defaultProps = {
  noDate: false,
  noTime: false,
};

export default DateTimeInput;