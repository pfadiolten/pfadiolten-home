import * as React from 'react';

interface Props extends React.DetailedHTMLProps<React.HTMLAttributes<HTMLDivElement>, HTMLDivElement> {
  children: string
}

const Html: React.FC<Props> = ({ children, ...rest }) => (
  <div {...rest} dangerouslySetInnerHTML={{ __html: children }} />
);

export default Html;