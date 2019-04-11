import * as React from 'react';
import { zeroPad } from '../../../../utils/helpers';

interface Props {
  time: Date
}

const LocalizedTime: React.FC<Props> = ({ time }) => {
  const values = [];
  values.push(zeroPad(time.getHours()));
  values.push(zeroPad(time.getMinutes()));
  return (
    <React.Fragment>{values.join(':')} Uhr</React.Fragment>
  );
};

export default LocalizedTime;