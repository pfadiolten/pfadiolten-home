import * as React from 'react';
import PhotoGallery, { PhotoClickHandler, PhotoProps } from 'react-photo-gallery';
import SimpleReactLightbox, { SRLWrapper } from 'simple-react-lightbox';

interface Props {
  images: {
    id: string,
    ratio: {
      width:  number,
      height: number,
    }
    src: {
      x128:  string,
      x256:  string,
      x512:  string,
      x1024: string,
    },
  }[]
}

const Gallery: React.FC<Props> = ({ images }) => {
  const photos: PhotoProps[] = images.map((image, i) => ({
    key:    image.id,
    src:    image.src.x256,
    alt:    `Bild ${i + 1}`,
    width:  image.ratio.width,
    height: image.ratio.height,
    srcSet: [
      `${image.src.x128} 128w`,
      `${image.src.x256} 256w`,
      `${image.src.x512} 512w`,
      `${image.src.x1024} 1024w`,
    ],
  }));

  return (
    <SimpleReactLightbox>
      <SRLWrapper>
        <PhotoGallery photos={photos} />
      </SRLWrapper>
    </SimpleReactLightbox>
  );
};

export {
  Gallery as default,
  Props as GalleryProps,
};
