/*
	Copyright (C) 2008, 2009 Andres Cabrera
	mantaraya36@gmail.com

	This file is part of CsoundQt.

	CsoundQt is free software; you can redistribute it
	and/or modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 2.1 of the License, or (at your option) any later version.

	CsoundQt is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU Lesser General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with Csound; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
	02111-1307 USA
*/

#ifndef DOTGENERATOR_H
#define DOTGENERATOR_H

#include <QtCore>

class OpEntryParser;
class Node;
class Port;

class DotGenerator
{
public:
	DotGenerator(QString fileName, QString orcText, OpEntryParser *opcodeTree);
	~DotGenerator();

	QString getDotText();
	Node createNode(QStringList parts);

	QString makeNodeText(const int i,
						 const int j,
						 const QString name,
						 QVector<Port> &inputs,
						 QVector<Port> &outputs);

	QString makeinputConnection(int i, int j, int n, Port input, QHash<QString, QString> &tokenSource);

protected:
	QString m_fileName, m_orcText;
	OpEntryParser *m_opcodeTree;

};

#endif
