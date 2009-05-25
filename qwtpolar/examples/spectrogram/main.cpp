#include <qapplication.h>
#include <qmainwindow.h>
#include <qtoolbar.h>
#include <qtoolbutton.h>
#include "plotwindow.h"
#include "plot.h"

class MainWindow: public QMainWindow
{
public:
    MainWindow(QWidget * = NULL);

private:
    PlotWindow *d_plotWindow;
};

MainWindow::MainWindow(QWidget *parent):
    QMainWindow(parent)
{
    d_plotWindow = new PlotWindow(this);
    setCentralWidget(d_plotWindow);

    QToolBar *toolBar = new QToolBar(this);

    QToolButton *btnPrint = new QToolButton(toolBar);
    QToolButton *btnGrid = new QToolButton(toolBar);

#if QT_VERSION >= 0x040000
    btnPrint->setText("Print");
    btnPrint->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);
    toolBar->addWidget(btnPrint);

    btnGrid->setText("Grid");
    btnGrid->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);
    btnGrid->setCheckable(true);
    btnGrid->setChecked(true);
    toolBar->addWidget(btnGrid);
#else
    btnPrint->setTextLabel("Print");
    btnPrint->setUsesTextLabel(true);

    btnGrid->setTextLabel("Print");
    btnGrid->setUsesTextLabel(true);
    btnGrid->setToggleButton(true);
    btnGrid->setOn(true);
#endif

    addToolBar(toolBar);

    connect(btnPrint, SIGNAL(clicked()), 
        d_plotWindow->plot(), SLOT(printPlot()) );
    connect(btnGrid, SIGNAL(toggled(bool)), 
        d_plotWindow->plot(), SLOT(showGrid(bool)) );
}

int main(int argc, char **argv)
{
    QApplication a(argc, argv);

    MainWindow mainWindow;
#if QT_VERSION < 0x040000
    a.setMainWidget(&mainWindow);
#endif

    mainWindow.resize(700,600);
    mainWindow.show();

    return a.exec(); 
}