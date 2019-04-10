import * as React from 'react';
import wretch from 'wretch';
import * as queryString from 'query-string';

interface Props<Result> {
  to:       string
  params:   object
  children: (data: Result, response: Response<Result>) => React.Node
}

interface State<Result> {
  response: Response<Result> | undefined
  loading:  boolean
}

interface Response<Result> {
  data:   Result
  routes: ResponseRoutes<Result>
}

type ResponseRoutes<Result> =
  Result extends unknown[] ? (
    {
      index: string | null,
      new:   string | null,
    }
  ) : (
    {
      show:    string | null,
      edit:    string | null,
      destroy: string | null,
    }
  );

class ApiRequest<Result> extends React.PureComponent<Props<Result>, State<Result>> {
  static defaultProps: Partial<Props<unknown>> = {
    params: {},
  };

  public state = {
    response: undefined,
    loading:  true,
  };

  public render() {
    const { loading, response } = this.state;
    if (loading) {
      return (
        <i className="fas fa-spinner fa-spin" />
      );
    }
    return this.props.children(response!.data, response!);
  }

  public async componentDidMount() {
    const url = this.generateUrl();
    const response = cache.get(url) as Response<Result>;
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
        response: json as Response<Result>,
      });
      cache.set(url, json);
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