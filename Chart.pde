public abstract class Chart//Gerard Moylan 25/3/22 Rewrote Chart class to use the GPlot library.
{                          //Gerard Moylan 2/4/22 Rewrote chart class, splitting it into multiple subclasses to tidy it up and avoid duplicated code
  int xPos; int yPos;
  String verticalText; String horizontalText; Float xLowerLim; Float xUpperLim; Float yLowerLim;
  Float yUpperLim; GPlot plot;
  String titleText;
  boolean isLineGraph;
  boolean isHistogram;
  GPointsArray points;
  boolean drawPoints;
  
  Chart(String verticalText, String horizontalText, Float xLowerLim, Float xUpperLim,
  Float yLowerLim, Float yUpperLim, String titleText)
  {
    xPos = Math.round(displayWidth/2.2);
    yPos = Math.round(displayHeight/10);
    this.verticalText=verticalText;
    this.horizontalText=horizontalText;
    this.xLowerLim=xLowerLim;
    this.xUpperLim=xUpperLim;
    this.yLowerLim=yLowerLim;
    this.yUpperLim=yUpperLim;
    this.titleText = titleText;
    plot = new GPlot(main, xPos, yPos);
    plot.setDim(new float[] {displayWidth/2.4, displayHeight/1.35});
    plot.setYLim(new float[] {yLowerLim, yUpperLim});
    plot.setXLim(new float[] {xLowerLim, xUpperLim});
    plot.getYAxis().getAxisLabel().setText(verticalText);
    plot.getYAxis().getAxisLabel().setTextAlignment(RIGHT);
    plot.getYAxis().getAxisLabel().setRelativePos(1);
    plot.getTitle().setText(titleText);
    plot.getXAxis().getAxisLabel().setText(horizontalText);
    plot.getXAxis().getAxisLabel().setTextAlignment(RIGHT);
    plot.getXAxis().getAxisLabel().setRelativePos(1);
    plot.getTitle().setTextAlignment(LEFT);
    plot.getTitle().setRelativePos(0);
    points = new GPointsArray();
    isLineGraph = false;
    isHistogram = false;
    drawPoints = true;
  }

  void addStringPoints(ArrayList<String> stringData, ArrayList<String> listOfUniqueElements)
  {
    for (int i = 0; i < xUpperLim; i++)
    {
        int histx = i;
        int histy = 0;
        for (int j = 0; j < stringData.size(); j++)
        {
            if (stringData.get(j).equalsIgnoreCase(listOfUniqueElements.get(i)))
            {
                histy++;
            }
        }
        points.add(histx,histy, listOfUniqueElements.get(i));
    }
    plot.setPoints(points);
  }
  void addFloatPoints(ArrayList<Float> floatData)
  {
    for (int i = 0; i <=xUpperLim; i++)
    {
      int histx = i;
      int histy = 0;
      for (int j = 0; j <floatData.size(); j++)
      {
        if (Math.round(floatData.get(j))==histx)
        {
          histy++;
        }
      }
      points.add(histx,histy);
    }
    plot.setPoints(points);
  }
  abstract void toHistogram();
  abstract void toLineGraph();
  void draw()
  {
    plot.beginDraw();
    plot.drawBackground();
    plot.drawBox();
    plot.drawYAxis();
    if (isLineGraph)
    {
      plot.drawPoints();
    }
    plot.drawTitle();
  }
}
public class Histogram extends Chart
{
  Histogram(String verticalText, String horizontalText, Float xLowerLim, Float xUpperLim,
            Float yLowerLim, Float yUpperLim, String titleText)
  {
    super(verticalText, horizontalText, xLowerLim, xUpperLim, yLowerLim, yUpperLim, titleText);
    plot.startHistograms(GPlot.VERTICAL);
    plot.getHistogram().setDrawLabels(true);
    plot.getHistogram().setRotateLabels(true);
    plot.getHistogram().setBgColors(new color[] {color(0, 0, 255, 50), color(0, 0, 255, 100), 
                                         color(0, 0, 255, 150), color(0, 0, 255, 200)});
    isLineGraph = false;
    isHistogram = true;
  }
  //Gerard Moylan 5/4/22 Turns histogram into line graph
  void toLineGraph()
  {
    isLineGraph = true;
  }
  //Gerard Moylan 5/4/22 Turns histogram that had been turned into a line graph, back into a histogram.
  void toHistogram()
  {
    isLineGraph = false;
  }
  void draw()
  {
    super.draw();
    if (isLineGraph)
    {
      plot.drawLines();
    }
    else
    {
      plot.drawHistograms();
    }
  }
}

public class FloatHistogram extends Histogram
{
  ArrayList<Float> floatData;
  FloatHistogram(String verticalText, String horizontalText, Float xLowerLim, Float xUpperLim,
                Float yLowerLim, Float yUpperLim, String titleText, ArrayList<Float> floatData)
  {
    super(verticalText, horizontalText, xLowerLim, xUpperLim, yLowerLim, yUpperLim, titleText);
    this.floatData = floatData;
    addFloatPoints(floatData);
    
  }
  void draw()
  {
    super.draw();
    plot.drawXAxis();
    plot.endDraw();
  }
}

public class StringHistogram extends Histogram
{
  ArrayList<String> stringData; 
  ArrayList<String> listOfUniqueElements;
  StringHistogram(String verticalText, String horizontalText, Float xLowerLim, Float xUpperLim,
                Float yLowerLim, Float yUpperLim, String titleText, ArrayList<String> stringData, ArrayList<String> listOfUniqueElements)
  {
    super(verticalText, horizontalText, xLowerLim, xUpperLim, yLowerLim, yUpperLim, titleText);
    this.stringData = stringData;
    this.listOfUniqueElements = listOfUniqueElements;
    addStringPoints(stringData, listOfUniqueElements);
  }
  void draw()
  {
    super.draw();
    plot.endDraw();
  }
}

public class LineGraph extends Chart
{
  LineGraph(String verticalText, String horizontalText, Float xLowerLim, Float xUpperLim,
            Float yLowerLim, Float yUpperLim, String titleText)
  {
    super(verticalText, horizontalText, xLowerLim, xUpperLim, yLowerLim, yUpperLim, titleText);
    isHistogram = false;
    isLineGraph=true;
  }
  void draw()
  {
    super.draw();
    if (isHistogram)
    {
      plot.drawHistograms();
    }
    else 
    {
      plot.drawLines();
      plot.drawPoints();
    }
  }
  //Gerard Moylan 5/4/22 Turns a line graph into a histogram
  void toHistogram()
  {
    plot.startHistograms(GPlot.VERTICAL);
    plot.getHistogram().setDrawLabels(true);
    plot.getHistogram().setRotateLabels(true);
    plot.getHistogram().setBgColors(new color[] {color(0, 0, 255, 50), color(0, 0, 255, 100), 
                                         color(0, 0, 255, 150), color(0, 0, 255, 200)});
    isHistogram = true;
  }
  //Gerard Moylan 5/4/22 Turns a line graph that had previously been turned into a histogram, back into a line graph
  void toLineGraph()
  {
    isHistogram = false;
  }
}

public class FloatLineGraph extends LineGraph
{
  ArrayList<Float> floatData;
  FloatLineGraph(String verticalText, String horizontalText, Float xLowerLim, Float xUpperLim,
            Float yLowerLim, Float yUpperLim, String titleText, ArrayList<Float> floatData)
  {
    super(verticalText, horizontalText, xLowerLim, xUpperLim, yLowerLim, yUpperLim, titleText);
    this.floatData = floatData;
    addFloatPoints(floatData);
  
  }
  void draw()
  {
    super.draw();
    plot.drawXAxis();
    plot.endDraw();
  }
}
public class StringLineGraph extends LineGraph
{
  ArrayList<String> stringData;
  ArrayList<String> listOfUniqueElements;
  StringLineGraph(String verticalText, String horizontalText, Float xLowerLim, Float xUpperLim,
            Float yLowerLim, Float yUpperLim, String titleText, ArrayList<String> stringData, ArrayList<String> listOfUniqueElements)
  {
    super(verticalText, horizontalText, xLowerLim, xUpperLim, yLowerLim, yUpperLim, titleText);
    this.stringData = stringData;
    this.listOfUniqueElements = listOfUniqueElements;
  }
  void draw()
  {
    super.draw();
    plot.endDraw();
  }
}

public class ScatterPlot extends Chart
{//Gerard Moylan 5/4/22 Added scatter plot class
  ArrayList<Float> xAxisVariable;
  ArrayList<Float> yAxisVariable;
  ScatterPlot(String verticalText, String horizontalText, Float xLowerLim, Float xUpperLim,
            Float yLowerLim, Float yUpperLim, String titleText, ArrayList<Float> xAxisVariable, ArrayList<Float> yAxisVariable)
  {
    super(verticalText, horizontalText, xLowerLim, xUpperLim, yLowerLim, yUpperLim, titleText);
    this.xAxisVariable = xAxisVariable;
    this.yAxisVariable = yAxisVariable;
    addScatterPoints();
  }
  void addScatterPoints()
  {
    for (int i = 0; i < xAxisVariable.size(); i++)
    {
      try
      {
      points.add(xAxisVariable.get(i), yAxisVariable.get(i));
      }catch (Exception e) {}
    }
    try
    {
      plot.setPoints(points);
    }catch (Exception e) {}
    
  }
  void toHistogram()
  {
    println("This doesn't do anything for a scatter plot lol ");
  }
  void toLineGraph()
  {
    println("This doesn't do anything for a scatter plot lol ");
  }
  void removePoints()//Gerard Moylan 6/4/22 Used to remove the points from the scatter plot before adding different points.
  {
    for (int i = points.getNPoints()-1; i > 0; i--)
    {
      try
      {
        points.remove(i);
      }catch(Exception e){}
    }
  }
  void updateParameters()//Gerard Moylan 6/4/22 used in the dynamic scatter plot
  {
    plot.setYLim(new float[] {yLowerLim, yUpperLim});
    plot.setXLim(new float[] {xLowerLim, xUpperLim});
    plot.getYAxis().getAxisLabel().setText(verticalText);
    plot.getTitle().setText(titleText);
    plot.getXAxis().getAxisLabel().setText(horizontalText);
  }
  void draw()
  {
    super.draw();
    plot.drawPoints();
    plot.drawXAxis();
    plot.endDraw();
  }
}

void swapCharts(ArrayList<Chart> charts)//Gerard Moylan 6/4/22 Used to change between line graph and histogram
{
  for (int i = 0; i < charts.size(); i++)
  {
    try
    {
      if (charts.get(i).isLineGraph)
    {
      charts.get(i).toHistogram();
    }
    else if (charts.get(i).isHistogram)
    {
      charts.get(i).toLineGraph();
    }
    }catch (Exception e) {}
  }
}
