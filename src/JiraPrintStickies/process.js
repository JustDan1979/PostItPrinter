const moment = require('moment');
const blobStream = require('blob-stream');

var hammersmithOneRegularPath = require('file-loader?name=[path][name].[ext]!./fonts/HammersmithOne-Regular.ttf');
require('file-loader?name=[path][name].[ext]!./fonts/LICENSE.txt');
var openSansSemiboldPath = require('file-loader?name=[path][name].[ext]!./fonts/OpenSans-Semibold.ttf');
require('file-loader?name=[path][name].[ext]!./fonts/OFL.txt');

import { CardDoc } from './card-document.js';

var fonts = {
  'Heading Font': hammersmithOneRegularPath,
  'Heading Bold Font': hammersmithOneRegularPath,
  'Body Font': openSansSemiboldPath
}

var taskCardProperties = {
  width: 144,
  height: 144,
  spacing: {
    horizontal: 14,
    vertical: 14
  },
  padding: 4,
  body: {
    margin: 3
  }
}

var storyCardProperties = {
  width: 216,
  height: 216,
  spacing: {
    horizontal: 36,
    vertical: 14
  },
  padding: 4,
  body: {
    margin: 3
  }
}

function getCardData(data) {
  let cardData = {
    project: data.fields.project.key,
    parentNum: data.fields.parent ? data.fields.parent.key.replace(data.fields.project.key + '-', '') : '',
    itemNum: data.key.replace(data.fields.project.key + '-', ''),
    body: data.fields.summary,
    created: moment(data.fields.created).format('MM/DD'),
    started: data.fields.customfield_15101 ? moment(data.fields.customfield_15101).format('MM/DD') : '',
    due: data.fields.duedate ? moment(data.fields.duedate).format('MM/DD') : ''
  };
  cardData.qable = cardData.body.includes('(qable)');
  cardData.spike = cardData.body.includes('research') || cardData.body.includes('Research');
  cardData.body = cardData.body.replace('(qable)', '');

  return cardData;
}

function outputTask(doc, data) {
  doc.addTaskCard(getCardData(data));
}

function outputStory(doc, data) {
  doc.addStoryCard(getCardData(data));
}

function outputIssue(doc, data) {
  if (data.issue.fields.issuetype.subtask) {
    doc.setCardProperties(taskCardProperties);
    outputTask(doc, data.issue);
  } else {
    // TODO handle print both story and task
    doc.setCardProperties(storyCardProperties);
    outputStory(doc, data.issue);
  }
}

function outputIssues(doc, data) {
  // Probably need to sort
  if (data.issues.total == 0) return;

  var shouldAddPage = true;
  let hasStories = false;

  data.issues.issues.sort((a, b) => {
    if (a.fields.issuetype.subtask === b.fields.issuetype.subtask) {
      return 0;
    } else if (a.fields.issuetype.subtask) {
      return 1;
    } else {
      return -1;
    }
  }).forEach(issue => {
    if (issue.fields.issuetype.subtask) {
      if (hasStories && shouldAddPage) {
        doc.changeCardType(taskCardProperties);
        shouldAddPage = false;
      }
      doc.setCardProperties(taskCardProperties);
      outputTask(doc, issue);
    } else {
      hasStories = true;
      doc.setCardProperties(storyCardProperties);
      outputStory(doc, issue);
    }
  });
}

function processIssue(doc, data) {
  let stream = doc.pipe(blobStream());

  outputIssue(doc, data);

  doc.end();

  stream.on('finish', function () {
    chrome.notifications.clear(data.notificationId);
    chrome.tabs.create({url: stream.toBlobURL('application/pdf')});
  })
}

function processIssues(doc, data) {
  let stream = doc.pipe(blobStream());

  outputIssues(doc, data);

  doc.end();

  stream.on('finish', function () {
    chrome.notifications.clear(data.notificationId);
    chrome.tabs.create({url: stream.toBlobURL('application/pdf')});
  })
}

function loadAndRegisterFont(doc, fontName, fontPath, callback) {
  var req = new XMLHttpRequest();
  req.addEventListener('load', () => {
    if (req.response) {
      doc.registerFont(fontName, req.response, '');
    }
    callback();
  });
  req.open('GET', chrome.runtime.getURL(fontPath));
  req.responseType = "arraybuffer";
  req.send();
}

function loadAndRegisterFontsFromList(doc, fontsToLoad, callback) {
  return () => {
    if (fontsToLoad.length > 0) {
      let fontName = fontsToLoad.shift();
      loadAndRegisterFont(doc, fontName, fonts[fontName], loadAndRegisterFontsFromList(doc, fontsToLoad, callback));
    } else {
      callback();
    }
  }
}

function loadAndRegisterFonts(doc, callback) {
  return loadAndRegisterFontsFromList(doc, Object.getOwnPropertyNames(fonts), callback)();
}

export function printIssue(data) {
  let doc = new CardDoc();

  loadAndRegisterFonts(doc, () => {
    processIssue(doc, data);
  });
};

export function printIssues(data) {
  let doc = new CardDoc();

  loadAndRegisterFonts(doc, () => {
    processIssues(doc, data);
  });
};
