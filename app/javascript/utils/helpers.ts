export const zeroPad = (value: number, minLength: number = 2) => {
  const stringValue = value.toString();
  if (stringValue.length >= minLength) {
    return stringValue;
  }
  const pad = '0'.repeat(minLength - stringValue.length);
  return `${pad}${stringValue}`;
};