import '@babel/polyfill';

import * as ActiveStorage from '@rails/activestorage';
ActiveStorage.start();

import '../components/init';
import '../utils/behaviour';