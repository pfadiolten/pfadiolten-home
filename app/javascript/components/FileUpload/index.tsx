import * as React from 'react';
import UIButton from '../UI/Button';
import { Col, Progress, Row } from 'reactstrap';
import meta from '../../utils/meta';

interface Props {
  title: string
  url:   string
}

interface State {
  progress?: number
}

class FileUpload extends React.PureComponent<Props, State> {
  public state: State = {
    progress: null,
  };

  private inputRef = React.createRef<HTMLInputElement>();

  public render() {
    const { title } = this.props;
    const { progress } = this.state;
    return (
      <Row>
        <Col>
          <Row>
            <Col>
              <UIButton title={title} color="primary" onClick={this.handleClick} block>
                {title}
              </UIButton>
              <input
                type="file"
                style={{ display: 'none' }}
                ref={this.inputRef}
                onChange={this.handleInput}
                multiple
              />
            </Col>
          </Row>
          <Row className="my-2" style={{ visibility: (progress == null ? 'hidden' : undefined) }}>
            <Col>
              <Progress color="ternary" value={progress} />
            </Col>
          </Row>
        </Col>
      </Row>
    );
  }

  private handleClick = () => {
    this.inputRef.current.click();
  };

  private handleInput: React.ChangeEventHandler<HTMLInputElement> = async (e) => {
    await this.setState({
      progress: 0,
    });

    const files = this.inputRef.current.files;

    const formData = new FormData();
    for (let i = 0; i < files.length; i += 1) {
      const file = files[i];
      formData.append('images[][file]', file);
    }

    const req = new XMLHttpRequest();
    // req.responseType = 'text';

    // req.addEventListener('load', this.handleUploadComplete, false);
    // req.addEventListener('readystatechange', this.handleUploadResponse(req), false);

    // TODO this does not seem to report anything
    req.upload.addEventListener('progress', this.handleUploadProgress, false);

    req.open('POST', this.props.url, true);
    req.setRequestHeader('X-CSRF-Token', meta.find('csrf-token'));
    req.setRequestHeader('Content-Type', 'multipart/form-data');
    req.send(formData);
  };

  private handleUploadProgress = (e: ProgressEvent) => {
    console.log(e, e.lengthComputable, e.total);
    const percent = (e.loaded / e.total) * 100;
    this.setState({
      progress: percent,
    });
  };

  private handleUploadComplete = async (e: ProgressEvent) => {
    await this.setState({
      progress: 100,
    });
    setTimeout(() => {
      this.setState({
        progress: null,
      });
    }, 1000);
  };

  private handleUploadResponse = (req: XMLHttpRequest) => () => {
    if (req.readyState !== req.DONE) {
      return;
    }

    if (req.status === 200) {
      // location.reload();
    } else {
      const json = JSON.parse(req.responseText);

      // TODO display this somewhere on the screen
      json.errors.forEach((error) => {
        console.error(error);
      });
    }
  };
}

export default FileUpload;