var PDFDocument = require('./pdfkit/pdfkit.js');

const PAGE_HEIGHT = 792;
const PAGE_WIDTH = 612;
const PAGE_MARGIN_LR = 36;
const PAGE_MARGIN_TB = 36;

var dotRadius = 8;
var numDots = 21;
var dotMinMargin = 4;

export class CardDoc extends PDFDocument {
  constructor() {
    super({autoFirstPage: false});
    this.cardCount = 0;
    this.col = 0;
    this.row = 0;
    this.column = { gap: 2 };
  }

  changeCardType(props) {
    this.cardCount = 0;
    this.col = 0;
    this.row = 0;
  }

  setCardProperties(props) {
    // TODO create page properties that are set at the beginning
    this.card = props
    this.card.content = {};
    this.maxCols = Math.floor((PAGE_WIDTH - 2 * PAGE_MARGIN_LR + this.card.spacing.horizontal) / (this.card.width + this.card.spacing.horizontal));
    this.maxRows = Math.floor((PAGE_HEIGHT - 2 * PAGE_MARGIN_TB + this.card.spacing.vertical) / (this.card.height + this.card.spacing.vertical));
    this.margin = {}
    this.margin.top = PAGE_MARGIN_TB;
    this.margin.left = PAGE_MARGIN_LR + (PAGE_WIDTH - 2 * PAGE_MARGIN_LR - this.maxCols * this.card.width - (this.maxCols - 1) * this.card.spacing.horizontal) / 2;
  }

  addCard() {
    if (this.cardCount % (this.maxRows * this.maxCols) == 0) {
      this.addPage();
    }

    this.row = Math.floor(Math.floor(this.cardCount / this.maxCols) % this.maxRows);
    this.col = this.cardCount % this.maxCols;

    this.card.x = this.margin.left + (this.col * (this.card.width + this.card.spacing.horizontal));
    this.card.y = this.margin.top + (this.row * (this.card.height + this.card.spacing.vertical));
    this.card.x2 = this.card.x + this.card.width;
    this.card.y2 = this.card.y + this.card.height;

    this.card.content = {}
    this.card.content.x = this.card.x + this.card.padding;
    this.card.content.y = this.card.y + this.card.padding;
    this.card.content.x2 = this.card.x2 - this.card.padding;
    this.card.content.y2 = this.card.y2 - this.card.padding;
    this.card.content.width = this.card.content.x2 - this.card.content.x;
    this.card.content.height = this.card.content.y2 - this.card.content.y2;

    this.card.column = null;

    this.cardCount++;
  }

  cardOutline() {
    this.rect(this.card.x, this.card.y, this.card.width, this.card.height);
    this.lineWidth(0.5);
    this.stroke();
  }

  addColumn(width) {
    if (!this.card.column) {
      this.card.column = { x: this.card.content.x, width: 0 }
    }
    this.card.column.x = this.card.column.x + this.card.column.width + this.column.gap;
    this.card.column.y = this.card.content.y;
    this.card.column.width = width ? width : this.card.content.x2 - this.card.column.x;
    this.card.column.height = this.card.content.height;
    this.card.column.x2 = this.card.column.x + this.card.column.width;
    this.card.column.y2 = this.card.content.y2;

    this.card.column.cursor = {};
    this.card.column.cursor.top = this.card.column.y;
    this.card.column.cursor.bottom = this.card.column.y2;
  }

  projectKey(text, x, y, width, fontSize) {
    width = width < 0 ? this.card.column.width + width : width;

    this.font('Heading Font');
    this.fontSize(fontSize);
    this.text(text, this.card.column.x + x, this.card.column.cursor.top + y, { width: width, align: 'right', height: fontSize - 2 });
    this._y += fontSize - 2;
  }

  parentNum(parentNum, x, y, width, fontSize) {
    width = width < 0 ? this.card.column.width + width : width;

    this.font('Heading Font');
    this.fontSize(fontSize);
    this.text(parentNum, this.card.column.x + x, this.card.column.cursor.top + y, { width: width, align: 'right' });
  }

  itemNum(itemNum, y) {
    this.font('Heading Bold Font');
    var width = this.widthOfString(itemNum);
    this.text(itemNum, this.card.column.x2 - width, this.card.column.cursor.top + y, { width: width, align: 'left' });

    return width;
  }

  horizontalLine(y, align) {
    if (!y) {
      y = 1;
    }
    if (align == 'bottom') {
      this.moveTo(this.card.column.x, this.card.column.cursor.bottom - y);
      this.lineTo(this.card.column.x2, this.card.column.cursor.bottom - y);
      this.card.column.cursor.bottom -= 1;
    } else {
      this.moveTo(this.card.column.x, this.card.column.cursor.top + y);
      this.lineTo(this.card.column.x2, this.card.column.cursor.top + y);
      this.card.column.cursor.top += 1;
    }
    this.lineWidth(1.5);
    this.stroke();
  }

  storyHeader(projectKey, parentNum, itemNum) {
    this.fontSize(31);
    var width = this.itemNum(itemNum, -3);
    this.projectKey(projectKey, 0, 0, -width, 18);
    this.parentNum(parentNum, 0, 15, -width, 11);
    this.card.column.cursor.top += 28;
  }

  subtaskHeader(projectKey, parentNum, itemNum) {
    this.fontSize(23);
    var width = this.itemNum(itemNum, -3);
    this.projectKey(projectKey, 0, 0, -width, 13);
    this.parentNum(parentNum, 0, 11, -width, 8);
    this.card.column.cursor.top += 20;
  }

  subtaskFooter(checks) {
    var doc = this;
    var minCheckWidth = 30;
    var checkHeight = 15;
    this.card.column.cursor.bottom -= checkHeight;
    var numChecks = Object.keys(checks).length;
    // TODO calculate based on actual text size
    var spacing = (this.card.column.width - numChecks * minCheckWidth) / (numChecks + 1);
    var num = 0;
    var card = this;
    Object.keys(checks).forEach(function (check) {
      doc.fontSize(8);
      let checkWidth = Math.min(minCheckWidth, card.widthOfString(check) + 6);
      doc.roundedRect(doc.card.column.x + checkWidth * num + spacing * (num + 1), doc.card.column.cursor.bottom, checkWidth, checkHeight, 2);
      doc.fillColor('#BBB');
      doc.lineWidth(0.5);
      if (checks[check]) {
        doc.fillAndStroke();
      }
      doc.fillColor('black');
      doc.strokeColor('black');
      doc.stroke();
      doc.font('Body Font');
      doc.text(check, doc.card.column.x + checkWidth * num + spacing * (num + 1) + checkWidth / 2 - doc.widthOfString(check) / 2, doc.card.column.cursor.bottom + checkHeight / 2 - 8 / 2 - 2);
      num++;
    });
  }

  bodyText(bodyText) {
    var height = this.card.column.cursor.bottom - this.card.column.cursor.top - this.card.body.margin * 2;
    this.font('Body Font');
    this.text(bodyText, this.card.column.x + this.card.body.margin, this.card.column.cursor.top + this.card.body.margin, { width: this.card.column.width - 2 * this.card.body.margin, height: height, ellipsis: true });
  }

  labelledText(label, text, fontSize, align) {
    var y = this.card.column.cursor.top;
    if (align == 'bottom') {
      this.card.column.cursor.bottom -= fontSize + 2;
      y = this.card.column.cursor.bottom;
    } else {
      this.card.column.cursor.top += fontSize + 2;
    }
    this.font('Heading Font');
    this.fontSize(fontSize - 3);
    this.fillColor('#777');
    let labelWidth = this.widthOfString(label) + 2;
    this.text(label, this.card.column.x, y + 3, { width: labelWidth });
    this.fillColor('black');
    this.fontSize(fontSize);
    this.text(text, this.card.column.x + labelWidth, y + 1, { width: this.card.column.width - labelWidth });
  }

  dots(dotRadius, dotMinMargin, numDots) {
    var dotBoxY = this.card.column.cursor.top;
    var dotBoxX = this.card.column.x;
    var dotBoxWidth = this.card.column.width;
    var dotBoxHeight = this.card.column.cursor.bottom - this.card.column.cursor.top;
    var dotWidth = dotRadius * 2
    var dotHeight = dotRadius * 2
    var dotMaxNumDotPerRow = Math.floor(dotBoxWidth  / (dotWidth + dotMinMargin))
    var dotMaxNumRows = Math.floor(dotBoxHeight  / (dotHeight + dotMinMargin))
    if (dotMaxNumRows * dotMaxNumDotPerRow < numDots) {
      console.log('Cant show all dots');
    }
    var dotNumDotPerRow = Math.min(numDots, dotMaxNumDotPerRow);
    var dotNumRows = Math.min(Math.max(Math.ceil(numDots / dotNumDotPerRow), 1), dotMaxNumRows);
    var dotVerticalMargin = (dotBoxHeight - dotHeight * dotNumRows) / (dotNumRows + 1)
    var dotHorizontalMargin = (dotBoxWidth - dotWidth * dotNumDotPerRow) / (dotNumDotPerRow + 1)
    for (var dotNum = 0; dotNum < numDots; dotNum++) {
      var dotRow = Math.floor(dotNum / dotNumDotPerRow);
      var dotCol = dotNum % dotNumDotPerRow;
      if (dotRow >= dotNumRows) {
        break;
      }
      var dotCenterX = dotBoxX + dotCol * dotWidth + (dotCol + 1) * dotHorizontalMargin + dotRadius
      var dotCenterY = dotBoxY + dotRow * dotHeight + (dotRow + 1) * dotVerticalMargin + dotRadius
      this.circle(dotCenterX, dotCenterY, dotRadius);
    }
    this.dash(1, { space: 2 });
    this.lineWidth(0.5);
    this.stroke();
    this.undash();
  }

  timeLineArrow(height, align) {
    var arrowHeadHeight = height / 2;
    var arrowHeadWidth = height / 2;
    var arrowheight = height;
    var middleX = this.card.column.x + this.card.column.width / 2;
    var y = this.card.column.cursor.top;
    if (align == 'bottom') {
      this.card.column.cursor.bottom -= height;
      y = this.card.column.cursor.bottom;
    } else {
      this.card.column.cursor.top += height;
    }
    this.moveTo(this.card.column.x, y);
    this.lineTo(this.card.column.x2, y);
    this.moveTo(middleX, y);
    this.lineTo(middleX, y + arrowheight);
    this.moveTo(middleX - arrowHeadWidth / 2, y + arrowheight - arrowHeadHeight);
    this.lineTo(middleX, y + arrowheight);
    this.moveTo(middleX + arrowHeadWidth / 2, y + arrowheight - arrowHeadHeight);
    this.lineTo(middleX, y + arrowheight);
    this.lineWidth(0.5);
    this.stroke();
  }

  addTaskCard(cardData) {
    this.addCard();

    // Draw box border - for debugging
    //this.cardOutline();

    this.addColumn(40);

    this.labelledText('C', cardData.created, 10);
    this.timeLineArrow(3);
    this.labelledText('S', cardData.started, 10);
    this.timeLineArrow(3);

    this.labelledText('D', cardData.due, 10, 'bottom');
    this.timeLineArrow(3, 'bottom');
    this.dots(dotRadius, dotMinMargin, numDots);

    this.addColumn();

    this.subtaskHeader(cardData.project, cardData.parentNum, cardData.itemNum);
    this.horizontalLine();
    this.subtaskFooter({qable: cardData.qable, spike: cardData.spike});
    this.fontSize(9);
    this.bodyText(cardData.body);
  }

  addStoryCard(cardData) {
    this.addCard();

    // Draw box border - for debugging
    // this.cardOutline();

    this.addColumn(60);

    this.labelledText('C', cardData.created, 16);
    this.timeLineArrow(3);
    this.labelledText('S', cardData.started, 16);
    this.timeLineArrow(3);

    this.labelledText('D', cardData.due, 16, 'bottom');
    this.timeLineArrow(3, 'bottom');
    this.dots(dotRadius, dotMinMargin, numDots);

    this.addColumn();

    this.storyHeader(cardData.project, cardData.parentNum, cardData.itemNum);
    this.horizontalLine();
    //doc2.subtaskFooter({ 'design review': false });
    this.fontSize(12);
    this.bodyText(cardData.body);
  }
}
