const find = (name: string) => {
  const metas = document.getElementsByTagName('meta');
  for (let i = 0; i < metas.length; i += 1) {
    const meta = metas[i];
    if (meta.getAttribute('name') === name) {
      return meta.getAttribute('content');
    }
  }
  throw new Error(`no such meta tag: ${name}`);
};

const meta = {
  find,
};

export default meta;