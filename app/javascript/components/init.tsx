import * as React from 'react';
import * as ReactDOM from 'react-dom';
import Reference from './UI/Reference';

const componentElements = document.getElementsByClassName('js-component');
for (let i = 0; i < componentElements.length; i += 1) {
  const element = componentElements[i] as HTMLElement;

  const { name: componentName, props } = JSON.parse(element.dataset.component);
  import(`./${componentName}`).then(({ default: Component }) => {
    const children = Array.from(element.children).map((child, i) => {
      element.removeChild(child);
      return <Reference element={child} key={i} />;
    });
    if (children.length > 0 && !('children' in props)) {
      props['children'] = children;
    }
    ReactDOM.render(
      <Component {...props} />,
      element,
    );
  }).catch((error) => {
    throw new Error(`unknown component: ${componentName}: ${error.message}`);
  });
}