import * as queryString from 'query-string';

interface Params {
  format?: 'html' | 'json'
}

type Route = (params?: Params) => string;

const makeRoute: (resource: string, action: string) => Route = (resource, action) => {
  const basePath = document.querySelector(`#routes > .resource--${resource} > .action--${action}`).innerHTML;
  return ({ format, ...params }: Params = {}) => {
    let path = basePath;
    if (format) {
      path = `${path}.${format}`;
    }
    path += queryString.stringify(params);
    return path;
  };
};

const routes: any = {
  events: makeRoute('events', 'index'),
};

export default routes;