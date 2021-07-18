#!/bin/bash

echo -e  "Please enter project title: "
read TITLE

DEPENDENCIES=("node -v", "code -v")

for i in "${DEPENDENCIES[@]}"
do
  command -v $i >/dev/null 2>&1 || { 
    echo >&2 "${i} is a required dependency. Please install it and try again."; 
    exit 1; 
  }
done

# create boilerplate
npx create-react-app $TITLE

# install node dependecies
cd $TITLE/ && npm i sass react-bootstrap

# remove the junk
cd src/ && rm -rf App.css App.test.js index.css logo.svg reportWebVitals.js setupTests.js

# build files
echo "* {
  box-sizing: border-box;
}

html, body {
  margin: 0;
}" > App.scss

echo "export default function App() {
  return (
    <>
      hello, react-bootstrap!
    </>
  );
}" > App.js

echo "import React from 'react';
import ReactDOM from 'react-dom';
import './App.scss';
import App from './App';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);" > index.js

# launch editor and start development server
cd .. && code .
npm start