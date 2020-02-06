const TAG_A = 'A';
const TAG_LI = 'LI';

const API_ROOT_PATH = 'https://eshipping.jira.com/rest/api/2/';
const API_ISSUE_PATH = API_ROOT_PATH + 'issue/';
const API_SEARCH_PATH = API_ROOT_PATH + 'search?jql=';

function getIssuePath(issueKey) {
  return API_ISSUE_PATH + encodeURIComponent(issueKey);
}

function getSearchPath(jql) {
  return API_SEARCH_PATH + encodeURIComponent(jql);
}

function getData(apiPath, callback) {
  var req = new XMLHttpRequest();
  req.addEventListener('load', function () {
    callback(req.response);
  });
  req.open('GET', apiPath);
  req.responseType = 'json';
  req.send();
}

function print(options) {
  if (options.jql) {
    getData(getSearchPath(options.jql), response => {
      chrome.runtime.sendMessage({ issues: response });
    });
  }
  else {
    getData(getIssuePath(options.issueId), response => {
      chrome.runtime.sendMessage({ issue: response });
    });
  }
}

function createAnchor(label, options) {
  let anchor = document.createElement(TAG_A);

  anchor.href = '';
  anchor.innerText = label;
  anchor.onclick = e => {
    e.preventDefault();
    print(options);
  }

  return anchor;
}

function createListItem(label, options) {
  let listItem = document.createElement(TAG_LI);

  listItem.appendChild(createAnchor(label, options));

  return listItem;
}

document.addEventListener('DOMContentLoaded', function () {
  document.getElementById('form').addEventListener('submit', event => {
    event.preventDefault();
    print({ issueId: document.getElementsByName('issueid').item(0).value });
  });

  chrome.tabs.query({ 'active': true, 'lastFocusedWindow': true }, tabs => {
    var parsedUrl = new URL(tabs[ 0 ].url);

    if (parsedUrl.hostname === 'eshipping.jira.com') {
      var list = document.getElementById('list');

      var pathMatch = /.*\/(browse|issues)\/(.+)$/i.exec(parsedUrl.pathname);
      if (pathMatch) {
        list.appendChild(createListItem(pathMatch[2], { issueId: pathMatch[2] }));
      }

      var jqlSearch = parsedUrl.searchParams.get('jql');
      if (jqlSearch) {
        list.appendChild(createListItem('Current search', { jql: jqlSearch }));
      }
    }
  });
});
