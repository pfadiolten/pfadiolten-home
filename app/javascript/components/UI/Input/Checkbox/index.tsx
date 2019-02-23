import * as React from 'react';
import { InputProps } from '../index';

interface Props extends InputProps {
  label:    string
  checked?: boolean
}

interface State {
  checked:   boolean
}

class CheckboxInput extends React.PureComponent<Props> {
  public static defaultProps: Partial<Props> = {
    checked: false,
  };

  public state: State = {
    checked:   this.props.checked,
  };

  public render() {
    const { label, name, id, ...inputProps } = this.props;
    const { checked } = this.state;

    const value = checked ? '1' : '0';
    // TODO
    // switch this from "p-switch p-fill" to "p-icon"
    // as soon as we have font-awesome per webpack/react

    return (
      <div className="pretty p-switch p-fill">
        <input
          {...inputProps}
          type="hidden"
          name={name}
          value={value}
          checked
          readOnly
        />
        <input
          {...inputProps}
          type="checkbox"
          id={id}
          value={value}
          checked={checked}
          onChange={this.onChange}
        />
        <div className="state">
          <label htmlFor={id}>{label}</label>
        </div>
      </div>
    );
  }

  private onChange = () => {
    const { checked } = this.state;
    this.setState({
      checked: !checked,
    });
  };
}
export default CheckboxInput;