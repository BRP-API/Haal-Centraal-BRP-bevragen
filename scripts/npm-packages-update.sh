#!/bin/sh

# delete package-lock.json
rm package-lock.json

# delete node_modules directory
rm -r node_modules

npm i -D @commitlint/cli@latest
npm i -D @commitlint/config-conventional@latest
npm i -D @cucumber/cucumber@latest
npm i -D @redocly/cli@latest
npm i -D @stoplight/spectral-cli@latest
npm i -D axios@latest
npm i -D chai@4.5.0
npm i -D commitizen@latest
npm i -D cz-conventional-changelog@latest
npm i -D deep-equal-in-any-order@latest
npm i -D husky@latest
npm i -D jest@latest
npm i -D multiple-cucumber-html-reporter@latest
npm i -D nswag@latest
npm i -D pg@latest
npm i -D winston@latest
