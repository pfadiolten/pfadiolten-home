import * as React from 'react';
import wretch from 'wretch';
import * as queryString from 'query-string';
import { List } from '../../../models/Record';

interface Props<Result> {
  to:       string
  params:   object
  children: (data: Result[], response: List<Result>) => React.Node
}

interface State<Result> {
  response?: List<Result>
  loading:   boolean
}

class ApiRequest<Result> extends React.PureComponent<Props<Result>, State<Result>> {
  static defaultProps: Partial<Props<unknown>> = {
    params: {},
  };

  public state: State<Result> = {
    loading:  true,
  };

  public render() {
    const { loading, response } = this.state;
    if (loading) {
      return (
        <i className="fas fa-spinner fa-spin" />
      );
    }
    if (!response) {
      return 'oh no!'; // TODO
    }
    return this.props.children(response.records, response);
  }

  public async componentDidMount() {
    const url = this.generateUrl();
    const response = cache.get(url) as List<Result>;
    if (response) {
      this.setState({
        response,
        loading: false,
      });
      return;
    }
    await api.url(url).get().json((json) => {
      this.setState({
        loading:  false,
        response: json as List<Result>,
      });
      cache.set(url, json);
    });
    this.setState({
      loading: false,
    });
  }

  private generateUrl() {
    const { to, params } = this.props;
    const urlParts = to.split('?', 2);
    const query = queryString.parse(urlParts[1]);
    const newParams = {};
    for (const key of Object.keys(query)) {
      newParams[key] = query[key];
    }
    for (const key of Object.keys(params)) {
      newParams[key] = params[key];
    }
    return `${urlParts[0] }?${queryString.stringify(newParams)}`;
  }
}

const cache = new Map<String, unknown>();

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')!;
const api = wretch()
  .headers({
    'X-CSRF-Token': csrfToken,
    Accept:         'application/json',
  })
;

export default ApiRequest;