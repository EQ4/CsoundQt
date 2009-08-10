/*
    Copyright (C) 2008, 2009 Andres Cabrera
    mantaraya36@gmail.com

    This file is part of QuteCsound.

    QuteCsound is free software; you can redistribute it
    and/or modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    QuteCsound is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with Csound; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA
*/

#ifndef DOCKHELP_H
#define DOCKHELP_H

#include <QDockWidget>
#include <QUrl>
#include "types.h"

class QTextBrowser;

class DockHelp : public QDockWidget
{
  Q_OBJECT
  public:
    DockHelp(QWidget *parent);

    ~DockHelp();

    bool hasFocus();

    void loadFile(QString fileName);
    bool externalBrowser;
    QString docDir;

  private:
    QTextBrowser *text;
    virtual void closeEvent(QCloseEvent * event);

  signals:
    void Close(bool visible);
    void openManualExample(QString fileName);

  public slots:
    void showManual();
    void showGen();
    void showOverview();
    void browseBack();
    void browseForward();
    void followLink(QUrl url);
    void copy();
};

#endif
