const TAG_DIV = 'DIV';
const TAG_A = 'A';
const TAG_SPAN = 'SPAN';
const TAG_LI = 'LI';

const TYPE_ISSUE = 0;
const TYPE_SEARCH = 1;
const TYPE_UNKNOWN = -1;

const CLASS_ACTIVE = 'active';
const CLASS_STICKIES = 'stickies-element';
const CLASS_AUI_LIST_ITEM = 'aui-list-item';

const SEARCH_DROPDOWN_LIST_SELECTOR = '#printdetails';

const API_ROOT_PATH = 'https://eshipping.jira.com/rest/api/2/';
const API_ISSUE_PATH = API_ROOT_PATH + 'issue/';
const API_SEARCH_PATH = API_ROOT_PATH + 'search?jql=';

const LABEL_PRINT_TASK = 'Print Sticky (Task)';
const LABEL_PRINT_STORY = 'Print Sticky (Story)';
const LABEL_PRINT_BUG = 'Print Sticky (Bug)';
const LABEL_PRINT_ISSUES = 'Print stickies';
const LABEL_PRINT_STORY_AND_TASKS = 'Print Stickies (Story + Tasks)';

function getIssuePath() {
  return API_ISSUE_PATH + encodeURIComponent(getIssueKey());
}

function getSearchPath(jql) {
  return API_SEARCH_PATH + encodeURIComponent(jql);
}

function getIssueType() {
  return document.getElementById('type-val').innerText.trim();
}

function getIssueKey() {
  return document.getElementById('key-val').dataset.issueKey;
}

function getJql() {
  return document.getElementsByName('jql')[0].value;
}

function isTask() {
  return getIssueType() === 'Technical task';
}

function isStory() {
  return getIssueType() === 'Story';
}

function isBug() {
  return getIssueType() === 'Bug';
}

function isIssueExportDropdown(node) {
  return node.tagName === TAG_DIV && node.id === 'viewissue-export_drop';
}

function isIssueSeachExportDropdown(node) {
  return node.tagName === TAG_DIV && node.classList.contains('header-views-menu');
}

function alreadyHasButtons(list) {
  return list.lastChild.classList.contains(CLASS_STICKIES);
}

function setActiveListItem(listItem) {
  return () => {
    if (listItem.parentNode) {
      let lis = listItem.parentNode.parentNode.getElementsByClassName(CLASS_AUI_LIST_ITEM);
      for (var i = 0; i < lis.length; i++) {
        lis[i].classList.remove(CLASS_ACTIVE);
      }
    }
    listItem.classList.add(CLASS_ACTIVE);
  }
}

function setInactiveListItem(listItem) {
  return () => {
    listItem.classList.remove(CLASS_ACTIVE);
  }
}

function createAnchor(type, label, options) {
  let anchor = document.createElement(TAG_A);

  anchor.href = '';
  anchor.onclick = e => {
    e.preventDefault();
    generateStickies(type, options);
  }

  if (type === TYPE_ISSUE) {
    let span = document.createElement(TAG_SPAN);
    span.classList.add('trigger-label');
    span.innerText = label;
    anchor.appendChild(span);
  } else if (type === TYPE_SEARCH) {
    anchor.classList.add('aui-list-item-link');
    anchor.innerText = label;
  }

  return anchor;
}

function createListItem(type, label, options) {
  let listItem = document.createElement(TAG_LI);

  listItem.classList.add(CLASS_AUI_LIST_ITEM, CLASS_STICKIES);
  listItem.appendChild(createAnchor(type, label, options));

  if (type === TYPE_SEARCH) {
    listItem.onmouseover = setActiveListItem(listItem);
    listItem.onmouseout = setInactiveListItem(listItem);
  }

  return listItem;
}

function addDropdownOption(option) {
  if (!option.list || alreadyHasButtons(option.list)) return;

  if (option.type === TYPE_ISSUE) {
    if (isTask()) {
      option.list.appendChild(createListItem(option.type, LABEL_PRINT_TASK));
    } else if (isStory()) {
      option.list.appendChild(createListItem(option.type, LABEL_PRINT_STORY));
      option.list.appendChild(createListItem(option.type, LABEL_PRINT_STORY_AND_TASKS, {includeTasks: true}));
    } else if (isBug()) {
      option.list.appendChild(createListItem(option.type, LABEL_PRINT_BUG));
    }
  } else if (option.type === TYPE_SEARCH) {
    option.list.appendChild(createListItem(option.type, LABEL_PRINT_ISSUES));
  }
}

function getDropdownList(type, node) {
  if (type === TYPE_ISSUE) {
    return node.firstChild;
  } else if (type === TYPE_SEARCH) {
    let selectedNode = node.querySelector(SEARCH_DROPDOWN_LIST_SELECTOR);
    return selectedNode ? selectedNode.parentNode.parentNode : null;
  }

  return null;
}

function getDropdownType(node) {
  if (isIssueExportDropdown(node)) {
    return TYPE_ISSUE;
  } else if (isIssueSeachExportDropdown(node)) {
    return TYPE_SEARCH;
  } else {
    return TYPE_UNKNOWN;
  }
}

function generateStickies(type, options) {
  if (type === TYPE_ISSUE) {
    if (options && options.includeTasks) {
      let issueKey = getIssueKey();
      getData(getSearchPath('id = ' + issueKey + ' or parent = ' + issueKey), response => {
        chrome.runtime.sendMessage({issues: response, options: options});
      });
    } else {
      getData(getIssuePath(), response => {
        chrome.runtime.sendMessage({issue: response, options: options});
      });
    }
  } else if (type === TYPE_SEARCH) {
    getData(getSearchPath(getJql()), response => {
      chrome.runtime.sendMessage({issues: response, options: options});
    });
  }
}

function getData(apiPath, callback) {
  var req = new XMLHttpRequest();
  req.addEventListener('load', function() {
    callback(req.response);
  });
  req.open('GET', apiPath);
  req.responseType = 'json';
  req.send();
}

var observer = new MutationObserver(mutations => {
  mutations.forEach(mutation => {
    nodeListToArray(mutation.addedNodes).filter(node => {
      return isIssueExportDropdown(node) || isIssueSeachExportDropdown(node);
    }).map(node => {
      let type = getDropdownType(node);
      return {type: type, list: getDropdownList(type, node)}
    }).forEach(addDropdownOption);
  });
});

function nodeListToArray(nodeList) {
  let arr = [];
  for (let i = 0; i < nodeList.length; i++) {
    arr[i] = nodeList[i];
  }
  return arr;
}

observer.observe(document, { childList: true, subtree: true });
