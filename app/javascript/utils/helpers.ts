export const zeroPad = (value: number, minLength: number = 2) => {
  const stringValue = value.toString();
  if (stringValue.length >= minLength) {
    return stringValue;
  }
  const pad = '0'.repeat(minLength - stringValue.length);
  return `${pad}${stringValue}`;
};

export const classes = {
  join: (...classList: (string|null|undefined)[]) => {
    let className = ' ';
    for (const currentClass of classList) {
      if (!currentClass || currentClass.length === 0) {
        continue;
      }
      if (className.length !== 0) {
        className += ' ';
      }
      className += currentClass;
    }
    return className;
  },

  merge: (classObject: { [key: string]: boolean } = {}) => {
    let className = ' ';
    for (const currentClass of Object.keys(classObject)) {
      const isIncluded = classObject[currentClass];
      if (!isIncluded) {
        continue;
      }
      if (className.length !== 0) {
        className += ' ';
      }
      className += currentClass;
    }
    return className;
  },
};