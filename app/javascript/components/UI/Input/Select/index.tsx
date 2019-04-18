import * as React from 'react';
import * as ReactDOM from 'react-dom';
import Choices from 'choices.js';

import styles from './index.module.scss';
import { classes } from '../../../../utils/helpers';

interface Props extends React.HTMLProps<HTMLSelectElement> {
  options: {
    name:  string
    value: string,
  }[]
}

class SelectInput extends React.PureComponent<Props> {
  private choices: Choices;

  public render() {
    const { options, className, ...selectProps } = this.props;
    return (
      <select {...selectProps}>
        {options.map(({ name, value }) => (
          <option value={value} key={value}>
            {name}
          </option>
        ))}
      </select>
    );
  }

  public componentDidMount() {
    const node = ReactDOM.findDOMNode(this) as HTMLElement;
    this.choices = new Choices(node, {
      removeItemButton: true,

      noResultsText:  'keine passenden Resultate',
      noChoicesText:  'keine weiteren Optionen vorhanden',
      itemSelectText: 'auswählen',
      addItemText:    '"${value}" hinzufügen',
      maxItemText:    'maximal ${maxItemCount} ausgewählte Optionen möglich',

      classNames: {
        containerOuter: classes.join('choices', styles.select),
      },
    });
  }

  public componentWillUnmount() {
    this.choices.destroy();
  }
}

export default SelectInput;