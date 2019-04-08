// source @
// https://github.com/rails/rails/blob/master/actiontext/app/javascript/actiontext/attachment_upload.js

import { DirectUpload } from '@rails/activestorage';

export class EditorInputUpload {
  private attachment: any;
  private element: any;
  private directUpload: any;

  constructor(attachment, element) {
    this.attachment = attachment;
    this.element = element;
    this.directUpload = new DirectUpload(attachment.file, this.directUploadUrl, this);
  }

  async start() {
    await this.directUpload.create(this.directUploadDidComplete.bind(this));
  }

  directUploadWillStoreFileWithXHR(xhr) {
    xhr.upload.addEventListener(0, (event) => {
      const progress = event.loaded / event.total * 100;
      this.attachment.setUploadProgress(progress);
    });
  }

  directUploadDidComplete(error, attributes) {
    if (error) {
      throw new Error(`Direct upload failed: ${error}`);
    }

    this.attachment.setAttributes({
      sgid: attributes.attachable_sgid,
      url: this.createBlobUrl(attributes.signed_id, attributes.filename),
    });
  }

  createBlobUrl(signedId, filename) {
    return this.blobUrlTemplate
      .replace(':signed_id', signedId)
      .replace(':filename', encodeURIComponent(filename));
  }

  get directUploadUrl() {
    return this.element.dataset.directUploadUrl;
  }

  get blobUrlTemplate() {
    return this.element.dataset.blobUrlTemplate;
  }
}