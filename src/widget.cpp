#include "widget.h"

#include <QVBoxLayout>

Widget::Widget(QWidget *parent) : QWidget(parent) {
  // Set window title
  setWindowTitle("Hello World Application");

  // Create label
  label = new QLabel("Hello World!", this);
  label->setAlignment(Qt::AlignCenter);

  // Create layout and add label
  QVBoxLayout *layout = new QVBoxLayout(this);
  layout->addWidget(label);

  // Set window size
  resize(250, 150);
}