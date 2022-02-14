import * as React from 'react';
import { Omit } from '../../../utils/types';

interface InputProps extends Omit<React.HTMLProps<HTMLInputElement>, 'value' | 'type'> {}

export {
  InputProps,
};
