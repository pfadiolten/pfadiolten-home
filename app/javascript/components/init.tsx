import FileUpload from './FileUpload';
import * as React from 'react';
import * as ReactDOM from 'react-dom';
import SearchList from './SearchList';
import Reference from './UI/Reference';
import User from './User';
import UserList from './User/List';

const components = {
  FileUpload,
  SearchList,
  User,
  UserList,
};

const componentElements = document.getElementsByClassName('js-component');
for (let i = 0; i < componentElements.length; i += 1) {
  const element = componentElements[i] as HTMLElement;

  const { name: componentName, props } = JSON.parse(element.dataset.component);
  const Component = components[componentName];
  if (Component == null) {
    throw new Error(`unknown component: ${componentName}`);
  }

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
}