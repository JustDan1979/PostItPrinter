require('file-loader?name=[name].[ext]!./manifest.json');
require('file-loader?name=[name].[ext]!./addStickiesOptions.js');
require('file-loader?name=[name].[ext]!./popup.js');
require('file-loader?name=[name].[ext]!./popup.html');

var icon16Url = require('file-loader?name=[name].[ext]!./eng_tech_logo_16.png');
var icon48Url = require('file-loader?name=[name].[ext]!./eng_tech_logo_48.png');
var icon128Url = require('file-loader?name=[name].[ext]!./eng_tech_logo_128.png');

import { printIssue, printIssues } from './process.js';

chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
  if (request.issues) {
    request.notificationId = getNotificationId();
    chrome.notifications.create(request.notificationId, getNotificationConfiguration());
    printIssues(request);
  } else if (request.issue) {
    request.notificationId = getNotificationId();
    chrome.notifications.create(request.notificationId, getNotificationConfiguration());
    printIssue(request);
  }
});

function getNotificationConfiguration() {
  return {
    type: 'basic',
    title: 'Jira Stickies',
    iconUrl: chrome.runtime.getURL(icon48Url),
    message: 'Your stickies are being generated'
  };
}

function getNotificationId() {
  return Math.floor(Math.random() * 100000) + '';
}
