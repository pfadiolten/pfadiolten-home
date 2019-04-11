import * as React from 'react';

interface Props {
  date: Date
}

const LocalizedDate: React.FC<Props> = ({ date }) => {
  return (
    <React.Fragment>
      {weekdays[date.getDay()]}, {date.getDate()}. {months[date.getMonth()]}
    </React.Fragment>
  );
};

const weekdays = [
  'Montag',
  'Dienstag',
  'Mittwoch',
  'Donnerstag',
  'Freitag',
  'Samstag',
  'Sonntag',
];

const months = [
  'Januar',
  'Februar',
  'März',
  'April',
  'Mai',
  'Juni',
  'Juli',
  'August',
  'September',
  'Oktober',
  'November',
  'Dezember',
];

export default LocalizedDate;