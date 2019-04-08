import * as React from 'react';
import 'trix/dist/trix';
import { EditorInputUpload } from './Upload';

import './index.scss';

interface Props {
  uploadURL:       string
  blobURLTemplate: string

  id:    string
  name:  string
  value: string
}

class EditorInput extends React.Component<Props> {
  private editorRef = React.createRef<any>();

  public render() {
    const { uploadURL, blobURLTemplate, id, name, value } = this.props;
    console.log(this.props);

    const Tag: any = 'trix-editor';
    return (
      <React.Fragment>
        <input id={id} name={name} defaultValue={value} type="hidden" />
        <Tag
          input={id}
          ref={this.editorRef}
          data-direct-upload-url={uploadURL}
          data-blob-url-template={blobURLTemplate}
          className="trix-content"
        />
      </React.Fragment>
    );
  }

  public componentDidMount() {
    this.editorRef.current.addEventListener('trix-attachment-add', this.handleAttachmentAdd);
  }

  public componentWillUnmount() {
    this.editorRef.current.removeEventListener('trix-attachment-add', this.handleAttachmentAdd);
  }

  private handleAttachmentAdd = ({ attachment, target }: any) => {
    if (!attachment.file) {
      return;
    }
    const upload = new EditorInputUpload(attachment, target);
    upload.start();
  };
}

export default EditorInput;