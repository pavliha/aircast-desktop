// widget.h
#ifndef WIDGET_H
#define WIDGET_H

#include <QLabel>
#include <QWidget>

class Widget : public QWidget {
  Q_OBJECT

 public:
  Widget(QWidget *parent = nullptr);
  ~Widget() = default;

 private:
  QLabel *label;
};

#endif  // WIDGET_H