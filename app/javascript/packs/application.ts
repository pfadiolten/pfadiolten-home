import Rails from '@rails/ujs';
import * as ActiveStorage from '@rails/activestorage';

import '../components/init';
import '../behaviour';

Rails.start();
ActiveStorage.start();
