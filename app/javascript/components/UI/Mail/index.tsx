import * as React from 'react';
import * as queryString from 'query-string';

interface Props {
  to:        string
  domain:    string
  subject?:  string
  body?:     string

  className: string
  children:  React.Node
}

interface State {
  active: boolean
}

class Mail extends React.PureComponent<Props, State> {
  static defaultProps: Partial<Props> = {
    domain: 'pfadiolten.ch',
  };

  public state = {
    active: false,
  };

  public render() {
    const { className, children } = this.props;
    return (
      <a
        href={this.buildHref()}
        onMouseEnter={this.activate}
        onMouseLeave={this.deactivate}
        className={className}
      >
        {children}
      </a>
    );
  }

  private buildHref = () => {
    const { active } = this.state;
    if (active) {
      const { to: receiver, domain, subject, body } = this.props;
      const right = `${receiver}${SEPARATOR}${domain}?${queryString.stringify({ subject, body })}`;
      return `mailto:${encodeURI(right)}`;
    }
    return '#';
  };

  private activate = () => {
    this.setState({
      active: true,
    });
  };

  private deactivate = () => {
    this.setState({
      active: false,
    });
  };
}

const SEPARATOR = '\u0040';

export default Mail;