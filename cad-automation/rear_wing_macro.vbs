Language="VBSCRIPT"

Sub CATMain()

Set partDocument1 = CATIA.ActiveDocument

Set part1 = partDocument1.Part

Set bodies1 = part1.Bodies

Set body1 = bodies1.Item("Third Element")

part1.InWorkObject = body1

Set hybridShapeFactory1 = part1.HybridShapeFactory

Set hybridShapeDirection1 = hybridShapeFactory1.AddNewDirectionByCoord(1.000000, 2.000000, 3.000000)

Set sketches1 = body1.Sketches

Set sketch1 = sketches1.Item("Sketch.3")

Set reference1 = part1.CreateReferenceFromObject(sketch1)

Set hybridShapeExtremum1 = hybridShapeFactory1.AddNewExtremum(reference1, hybridShapeDirection1, 1)

body1.InsertHybridShape hybridShapeExtremum1

part1.InWorkObject = hybridShapeExtremum1

part1.Update 

Set reference2 = part1.CreateReferenceFromObject(sketch1)

Set reference3 = part1.CreateReferenceFromObject(hybridShapeExtremum1)

Set hybridShapePointOnCurve1 = hybridShapeFactory1.AddNewPointOnCurveWithReferenceFromDistance(reference2, reference3, 0.000000, False)

hybridShapePointOnCurve1.DistanceType = 1

body1.InsertHybridShape hybridShapePointOnCurve1

part1.InWorkObject = hybridShapePointOnCurve1

part1.Update 

Set body2 = bodies1.Item("Third Element_EXT")

part1.InWorkObject = body2

Set hybridShapeDirection2 = hybridShapeFactory1.AddNewDirectionByCoord(1.000000, 2.000000, 3.000000)

Set sketches2 = body2.Sketches

Set sketch2 = sketches2.Item("Sketch.6")

Set reference4 = part1.CreateReferenceFromObject(sketch2)

Set hybridShapeExtremum2 = hybridShapeFactory1.AddNewExtremum(reference4, hybridShapeDirection2, 1)

body2.InsertHybridShape hybridShapeExtremum2

part1.InWorkObject = hybridShapeExtremum2

part1.Update 

Set reference5 = part1.CreateReferenceFromObject(sketch2)

Set reference6 = part1.CreateReferenceFromObject(hybridShapeExtremum2)

Set hybridShapePointOnCurve2 = hybridShapeFactory1.AddNewPointOnCurveWithReferenceFromDistance(reference5, reference6, 0.000000, False)

hybridShapePointOnCurve2.DistanceType = 1

body2.InsertHybridShape hybridShapePointOnCurve2

part1.InWorkObject = hybridShapePointOnCurve2

part1.Update 

Set hybridBodies1 = part1.HybridBodies

Set hybridBody1 = hybridBodies1.Add()

part1.Update 

Set sketches3 = hybridBody1.HybridSketches

Set originElements1 = part1.OriginElements

Set reference7 = originElements1.PlaneZX

Set sketch3 = sketches3.Add(reference7)

Dim arrayOfVariantOfDouble1(8)
arrayOfVariantOfDouble1(0) = 0.000000
arrayOfVariantOfDouble1(1) = 0.000000
arrayOfVariantOfDouble1(2) = 0.000000
arrayOfVariantOfDouble1(3) = -1.000000
arrayOfVariantOfDouble1(4) = 0.000000
arrayOfVariantOfDouble1(5) = 0.000000
arrayOfVariantOfDouble1(6) = 0.000000
arrayOfVariantOfDouble1(7) = -0.000000
arrayOfVariantOfDouble1(8) = 1.000000
sketch3.SetAbsoluteAxisData arrayOfVariantOfDouble1

part1.InWorkObject = sketch3

Set factory2D1 = sketch3.OpenEdition()

Set geometricElements1 = sketch3.GeometricElements

Set axis2D1 = geometricElements1.Item("AbsoluteAxis")

Set line2D1 = axis2D1.GetItem("HDirection")

line2D1.ReportName = 1

Set line2D2 = axis2D1.GetItem("VDirection")

line2D2.ReportName = 2

Set point2D1 = factory2D1.CreatePoint(-318.307766, 618.043386)

point2D1.ReportName = 3

Set point2D2 = factory2D1.CreatePoint(275.000000, 618.043386)

point2D2.ReportName = 4

Set line2D3 = factory2D1.CreateLine(-318.307766, 618.043386, 275.000000, 618.043386)

line2D3.ReportName = 5

line2D3.StartPoint = point2D1

line2D3.EndPoint = point2D2

Set point2D3 = factory2D1.CreatePoint(275.000000, -40.000000)

point2D3.ReportName = 6

Set line2D4 = factory2D1.CreateLine(275.000000, 618.043386, 275.000000, -40.000000)

line2D4.ReportName = 7

line2D4.EndPoint = point2D2

line2D4.StartPoint = point2D3

Set point2D4 = factory2D1.CreatePoint(-318.307766, -40.000000)

point2D4.ReportName = 8

Set line2D5 = factory2D1.CreateLine(275.000000, -40.000000, -318.307766, -40.000000)

line2D5.ReportName = 9

line2D5.StartPoint = point2D3

line2D5.EndPoint = point2D4

Set line2D6 = factory2D1.CreateLine(-318.307766, -40.000000, -318.307766, 618.043386)

line2D6.ReportName = 10

line2D6.EndPoint = point2D4

line2D6.StartPoint = point2D1

Set constraints1 = sketch3.Constraints

Set reference8 = part1.CreateReferenceFromObject(line2D3)

Set reference9 = part1.CreateReferenceFromObject(line2D1)

Set constraint1 = constraints1.AddBiEltCst(catCstTypeHorizontality, reference8, reference9)

constraint1.Mode = catCstModeDrivingDimension

Set reference10 = part1.CreateReferenceFromObject(line2D5)

Set reference11 = part1.CreateReferenceFromObject(line2D1)

Set constraint2 = constraints1.AddBiEltCst(catCstTypeHorizontality, reference10, reference11)

constraint2.Mode = catCstModeDrivingDimension

Set reference12 = part1.CreateReferenceFromObject(line2D4)

Set reference13 = part1.CreateReferenceFromObject(line2D2)

Set constraint3 = constraints1.AddBiEltCst(catCstTypeVerticality, reference12, reference13)

constraint3.Mode = catCstModeDrivingDimension

Set reference14 = part1.CreateReferenceFromObject(line2D6)

Set reference15 = part1.CreateReferenceFromObject(line2D2)

Set constraint4 = constraints1.AddBiEltCst(catCstTypeVerticality, reference14, reference15)

constraint4.Mode = catCstModeDrivingDimension

Set reference16 = part1.CreateReferenceFromObject(line2D5)

Set reference17 = part1.CreateReferenceFromObject(line2D1)

Set constraint5 = constraints1.AddBiEltCst(catCstTypeDistance, reference16, reference17)

constraint5.Mode = catCstModeDrivingDimension

Set length1 = constraint5.Dimension

length1.Value = 40.000000

Set reference18 = part1.CreateReferenceFromObject(line2D4)

Set reference19 = part1.CreateReferenceFromObject(line2D2)

Set constraint6 = constraints1.AddBiEltCst(catCstTypeDistance, reference18, reference19)

constraint6.Mode = catCstModeDrivingDimension

Set length2 = constraint6.Dimension

length2.Value = 275.000000

Set hybridShapes1 = body2.HybridShapes

Set reference20 = hybridShapes1.Item("Point.2")

Set geometricElements2 = factory2D1.CreateProjections(reference20)

Set geometry2D1 = geometricElements2.Item("Mark.1")

geometry2D1.Construction = True

Set reference21 = part1.CreateReferenceFromObject(line2D6)

Set reference22 = part1.CreateReferenceFromObject(geometry2D1)

Set constraint7 = constraints1.AddBiEltCst(catCstTypeDistance, reference21, reference22)

constraint7.Mode = catCstModeDrivingDimension

Set length3 = constraint7.Dimension

length3.Value = 40.000000

Set geometricElements3 = factory2D1.CreateProjections(reference20)

Set geometry2D2 = geometricElements3.Item("Mark.1")

geometry2D2.Construction = True

Set reference23 = part1.CreateReferenceFromObject(line2D3)

Set reference24 = part1.CreateReferenceFromObject(geometry2D2)

Set constraint8 = constraints1.AddBiEltCst(catCstTypeDistance, reference23, reference24)

constraint8.Mode = catCstModeDrivingDimension

Set length4 = constraint8.Dimension

length4.Value = 40.000000

sketch3.CloseEdition 

part1.InWorkObject = hybridBody1

part1.Update 

length1.Value = 40.000000

length2.Value = 275.000000

length3.Value = 40.000000

length4.Value = 40.000000

length1.Value = 40.000000

length2.Value = 275.000000

length3.Value = 40.000000

length4.Value = 40.000000

Set hybridShapeFill1 = hybridShapeFactory1.AddNewFill()

Set reference25 = part1.CreateReferenceFromObject(sketch3)

hybridShapeFill1.AddBound reference25

hybridShapeFill1.Continuity = 0

hybridBody1.AppendHybridShape hybridShapeFill1

part1.InWorkObject = hybridShapeFill1

part1.Update 

Set hybridShapePlaneExplicit1 = originElements1.PlaneZX

Set reference26 = part1.CreateReferenceFromObject(hybridShapePlaneExplicit1)

Set hybridShapeDirection3 = hybridShapeFactory1.AddNewDirection(reference26)

Set reference27 = part1.CreateReferenceFromObject(hybridShapeFill1)

Set hybridShapeExtrude1 = hybridShapeFactory1.AddNewExtrude(reference27, 4.000000, 0.000000, hybridShapeDirection3)

hybridShapeExtrude1.SymmetricalExtension = 0

hybridBody1.AppendHybridShape hybridShapeExtrude1

part1.InWorkObject = hybridShapeExtrude1

part1.Update 

Set hybridBody2 = hybridBodies1.Add()

part1.Update 

Set hybridBody3 = hybridBodies1.Item("Airfoil gaps")

Set hybridShapes2 = hybridBody3.HybridShapes

Set hybridShapePlaneOffset1 = hybridShapes2.Item("Plane.3")

Set reference28 = part1.CreateReferenceFromObject(hybridShapePlaneOffset1)

Set hybridShapeDirection4 = hybridShapeFactory1.AddNewDirection(reference28)

Set body3 = bodies1.Item("Main Element")

Set sketches4 = body3.Sketches

Set sketch4 = sketches4.Item("Sketch.1")

Set reference29 = part1.CreateReferenceFromObject(sketch4)

Set hybridShapeExtrude2 = hybridShapeFactory1.AddNewExtrude(reference29, 4.000000, 0.000000, hybridShapeDirection4)

hybridShapeExtrude2.FirstLimitType = 2

Set reference30 = part1.CreateReferenceFromObject(hybridShapePlaneOffset1)

hybridShapeExtrude2.FirstUptoElement = reference30

hybridShapeExtrude2.SymmetricalExtension = 0

hybridBody2.AppendHybridShape hybridShapeExtrude2

part1.InWorkObject = hybridShapeExtrude2

part1.Update 

Set hybridBody4 = hybridBodies1.Add()

part1.Update 

Set hybridShapeDirection5 = hybridShapeFactory1.AddNewDirectionByCoord(0.000000, 0.000000, 0.000000)

Set body4 = bodies1.Item("Second Element")

Set sketches5 = body4.Sketches

Set sketch5 = sketches5.Item("Sketch.2")

Set reference31 = part1.CreateReferenceFromObject(sketch5)

Set hybridShapeExtrude3 = hybridShapeFactory1.AddNewExtrude(reference31, 4.000000, 0.000000, hybridShapeDirection5)

hybridShapeExtrude3.FirstLimitType = 2

Set reference32 = part1.CreateReferenceFromObject(hybridShapePlaneOffset1)

hybridShapeExtrude3.FirstUptoElement = reference32

hybridShapeExtrude3.SymmetricalExtension = 0

hybridBody4.AppendHybridShape hybridShapeExtrude3

part1.InWorkObject = hybridShapeExtrude3

part1.Update 

Set hybridBody5 = hybridBodies1.Add()

part1.Update 

Set reference33 = part1.CreateReferenceFromObject(hybridShapePlaneOffset1)

Set hybridShapeDirection6 = hybridShapeFactory1.AddNewDirection(reference33)

Set reference34 = part1.CreateReferenceFromObject(sketch1)

Set hybridShapeExtrude4 = hybridShapeFactory1.AddNewExtrude(reference34, 4.000000, 0.000000, hybridShapeDirection6)

hybridShapeExtrude4.FirstLimitType = 2

Set reference35 = part1.CreateReferenceFromObject(hybridShapePlaneOffset1)

hybridShapeExtrude4.FirstUptoElement = reference35

hybridShapeExtrude4.SymmetricalExtension = 0

hybridBody5.AppendHybridShape hybridShapeExtrude4

part1.InWorkObject = hybridShapeExtrude4

part1.Update 

Set body5 = bodies1.Add()

part1.Update 

Set shapeFactory1 = part1.ShapeFactory

Set reference36 = part1.CreateReferenceFromName("")

Set closeSurface1 = shapeFactory1.AddNewCloseSurface(reference36)

Set reference37 = part1.CreateReferenceFromObject(hybridShapeExtrude1)

closeSurface1.Surface = reference37

part1.Update 

Set reference38 = part1.CreateReferenceFromName("")

Set closeSurface2 = shapeFactory1.AddNewCloseSurface(reference38)

Set reference39 = part1.CreateReferenceFromObject(hybridShapeExtrude2)

closeSurface2.Surface = reference39

part1.Update 

Set reference40 = part1.CreateReferenceFromName("")

Set closeSurface3 = shapeFactory1.AddNewCloseSurface(reference40)

Set reference41 = part1.CreateReferenceFromObject(hybridShapeExtrude3)

closeSurface3.Surface = reference41

part1.Update 

Set reference42 = part1.CreateReferenceFromName("")

Set closeSurface4 = shapeFactory1.AddNewCloseSurface(reference42)

Set reference43 = part1.CreateReferenceFromObject(hybridShapeExtrude4)

closeSurface4.Surface = reference43

part1.Update 

Set selection1 = partDocument1.Selection

Set visPropertySet1 = selection1.VisProperties

Set hybridBodies1 = hybridBody1.Parent

Dim bSTR1
bSTR1 = hybridBody1.Name

selection1.Add hybridBody1

Set hybridBodies1 = hybridBody2.Parent

Dim bSTR2
bSTR2 = hybridBody2.Name

selection1.Add hybridBody2

Set hybridBodies1 = hybridBody4.Parent

Dim bSTR3
bSTR3 = hybridBody4.Name

selection1.Add hybridBody4

Set hybridBodies1 = hybridBody5.Parent

Dim bSTR4
bSTR4 = hybridBody5.Name

selection1.Add hybridBody5

Set visPropertySet1 = visPropertySet1.Parent

Dim bSTR5
bSTR5 = visPropertySet1.Name

Dim bSTR6
bSTR6 = visPropertySet1.Name

visPropertySet1.SetShow 1

selection1.Clear 

Set sketches6 = body5.Sketches

Set reference44 = part1.CreateReferenceFromName("Selection_RSur:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;2:(Brp:(GSMFill.1)))));None:();Cf11:());CloseSurface.4_ResultOUT;Z0;G4074)")

Set sketch6 = sketches6.Add(reference44)

Dim arrayOfVariantOfDouble2(8)
arrayOfVariantOfDouble2(0) = 0.000000
arrayOfVariantOfDouble2(1) = 4.000000
arrayOfVariantOfDouble2(2) = 0.000000
arrayOfVariantOfDouble2(3) = -1.000000
arrayOfVariantOfDouble2(4) = 0.000000
arrayOfVariantOfDouble2(5) = 0.000000
arrayOfVariantOfDouble2(6) = 0.000000
arrayOfVariantOfDouble2(7) = -0.000000
arrayOfVariantOfDouble2(8) = 1.000000
sketch6.SetAbsoluteAxisData arrayOfVariantOfDouble2

part1.InWorkObject = sketch6

Set factory2D2 = sketch6.OpenEdition()

Set geometricElements4 = sketch6.GeometricElements

Set axis2D2 = geometricElements4.Item("AbsoluteAxis")

Set line2D7 = axis2D2.GetItem("HDirection")

line2D7.ReportName = 1

Set line2D8 = axis2D2.GetItem("VDirection")

line2D8.ReportName = 2

Set point2D5 = factory2D2.CreatePoint(-125.000000, -40.000000)

point2D5.ReportName = 3

Set point2D6 = factory2D2.CreatePoint(-318.307766, -40.000000)

point2D6.ReportName = 4

Set line2D9 = factory2D2.CreateLine(-125.000000, -40.000000, -318.307766, -40.000000)

line2D9.ReportName = 5

line2D9.StartPoint = point2D5

line2D9.EndPoint = point2D6

Set constraints2 = sketch6.Constraints

Set reference45 = part1.CreateReferenceFromObject(line2D9)

Set reference46 = part1.CreateReferenceFromObject(line2D7)

Set constraint9 = constraints2.AddBiEltCst(catCstTypeHorizontality, reference45, reference46)

constraint9.Mode = catCstModeDrivingDimension

Set point2D7 = factory2D2.CreatePoint(-318.307766, 368.043386)

point2D7.ReportName = 6

Set line2D10 = factory2D2.CreateLine(-318.307766, -40.000000, -318.307766, 368.043386)

line2D10.ReportName = 7

line2D10.StartPoint = point2D6

line2D10.EndPoint = point2D7

Set reference47 = part1.CreateReferenceFromObject(line2D10)

Set reference48 = part1.CreateReferenceFromObject(line2D8)

Set constraint10 = constraints2.AddBiEltCst(catCstTypeVerticality, reference47, reference48)

constraint10.Mode = catCstModeDrivingDimension

Set line2D11 = factory2D2.CreateLine(-318.307766, 368.043386, -125.000000, -40.000000)

line2D11.ReportName = 8

line2D11.StartPoint = point2D7

line2D11.EndPoint = point2D5

Set reference49 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;9)))))));None:();Cf11:());Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;2:(Brp:(GSMFill.1)))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", closeSurface1)

Set geometricElements5 = factory2D2.CreateProjections(reference49)

Set geometry2D3 = geometricElements5.Item("Mark.1")

geometry2D3.Construction = True

Set reference50 = part1.CreateReferenceFromObject(line2D9)

Set reference51 = part1.CreateReferenceFromObject(geometry2D3)

Set constraint11 = constraints2.AddBiEltCst(catCstTypeOn, reference50, reference51)

constraint11.Mode = catCstModeDrivingDimension

Set reference52 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;10)))))));None:();Cf11:());Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;2:(Brp:(GSMFill.1)))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", closeSurface1)

Set geometricElements6 = factory2D2.CreateProjections(reference52)

Set geometry2D4 = geometricElements6.Item("Mark.1")

geometry2D4.Construction = True

Set reference53 = part1.CreateReferenceFromObject(line2D10)

Set reference54 = part1.CreateReferenceFromObject(geometry2D4)

Set constraint12 = constraints2.AddBiEltCst(catCstTypeOn, reference53, reference54)

constraint12.Mode = catCstModeDrivingDimension

Set reference55 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;7)))))));None:();Cf11:());Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;2:(Brp:(GSMFill.1)))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", closeSurface1)

Set geometricElements7 = factory2D2.CreateProjections(reference55)

Set geometry2D5 = geometricElements7.Item("Mark.1")

geometry2D5.Construction = True

Set reference56 = part1.CreateReferenceFromObject(point2D5)

Set reference57 = part1.CreateReferenceFromObject(geometry2D5)

Set constraint13 = constraints2.AddBiEltCst(catCstTypeDistance, reference56, reference57)

constraint13.Mode = catCstModeDrivingDimension

Set length5 = constraint13.Dimension

length5.Value = 400.000000

Set reference58 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;5)))))));None:();Cf11:());Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;2:(Brp:(GSMFill.1)))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", closeSurface1)

Set geometricElements8 = factory2D2.CreateProjections(reference58)

Set geometry2D6 = geometricElements8.Item("Mark.1")

geometry2D6.Construction = True

Set reference59 = part1.CreateReferenceFromObject(point2D7)

Set reference60 = part1.CreateReferenceFromObject(geometry2D6)

Set constraint14 = constraints2.AddBiEltCst(catCstTypeDistance, reference59, reference60)

constraint14.Mode = catCstModeDrivingDimension

Set length6 = constraint14.Dimension

length6.Value = 250.000000

Set point2D8 = factory2D2.CreatePoint(129.066551, 618.043386)

point2D8.ReportName = 9

Set point2D9 = factory2D2.CreatePoint(275.000000, 618.043386)

point2D9.ReportName = 10

Set line2D12 = factory2D2.CreateLine(129.066551, 618.043386, 275.000000, 618.043386)

line2D12.ReportName = 11

line2D12.StartPoint = point2D8

line2D12.EndPoint = point2D9

Set reference61 = part1.CreateReferenceFromObject(line2D12)

Set reference62 = part1.CreateReferenceFromObject(line2D7)

Set constraint15 = constraints2.AddBiEltCst(catCstTypeHorizontality, reference61, reference62)

constraint15.Mode = catCstModeDrivingDimension

Set point2D10 = factory2D2.CreatePoint(275.000000, 310.000000)

point2D10.ReportName = 12

Set line2D13 = factory2D2.CreateLine(275.000000, 618.043386, 275.000000, 310.000000)

line2D13.ReportName = 13

line2D13.StartPoint = point2D9

line2D13.EndPoint = point2D10

Set reference63 = part1.CreateReferenceFromObject(line2D13)

Set reference64 = part1.CreateReferenceFromObject(line2D8)

Set constraint16 = constraints2.AddBiEltCst(catCstTypeVerticality, reference63, reference64)

constraint16.Mode = catCstModeDrivingDimension

Set line2D14 = factory2D2.CreateLine(275.000000, 310.000000, 129.066551, 618.043386)

line2D14.ReportName = 14

line2D14.StartPoint = point2D10

line2D14.EndPoint = point2D8

Set reference65 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;7)))))));None:();Cf11:());Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;2:(Brp:(GSMFill.1)))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", closeSurface1)

Set geometricElements9 = factory2D2.CreateProjections(reference65)

Set geometry2D7 = geometricElements9.Item("Mark.1")

geometry2D7.Construction = True

Set reference66 = part1.CreateReferenceFromObject(geometry2D7)

Set reference67 = part1.CreateReferenceFromObject(line2D13)

Set constraint17 = constraints2.AddBiEltCst(catCstTypeOn, reference66, reference67)

constraint17.Mode = catCstModeDrivingDimension

Set reference68 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;5)))))));None:();Cf11:());Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;2:(Brp:(GSMFill.1)))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", closeSurface1)

Set geometricElements10 = factory2D2.CreateProjections(reference68)

Set geometry2D8 = geometricElements10.Item("Mark.1")

geometry2D8.Construction = True

Set reference69 = part1.CreateReferenceFromObject(line2D12)

Set reference70 = part1.CreateReferenceFromObject(geometry2D8)

Set constraint18 = constraints2.AddBiEltCst(catCstTypeOn, reference69, reference70)

constraint18.Mode = catCstModeDrivingDimension

Set reference71 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;9)))))));None:();Cf11:());Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;2:(Brp:(GSMFill.1)))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", closeSurface1)

Set geometricElements11 = factory2D2.CreateProjections(reference71)

Set geometry2D9 = geometricElements11.Item("Mark.1")

geometry2D9.Construction = True

Set reference72 = part1.CreateReferenceFromObject(point2D10)

Set reference73 = part1.CreateReferenceFromObject(geometry2D9)

Set constraint19 = constraints2.AddBiEltCst(catCstTypeDistance, reference72, reference73)

constraint19.Mode = catCstModeDrivingDimension

Set length7 = constraint19.Dimension

length7.Value = 350.000000

Set reference74 = part1.CreateReferenceFromObject(line2D14)

Set reference75 = part1.CreateReferenceFromObject(line2D11)

Set constraint20 = constraints2.AddBiEltCst(catCstTypeParallelism, reference74, reference75)

constraint20.Mode = catCstModeDrivingDimension

sketch6.CloseEdition 

part1.InWorkObject = sketch6

part1.Update 

length5.Value = 400.000000

length6.Value = 250.000000

length7.Value = 350.000000

length5.Value = 400.000000

length6.Value = 250.000000

length7.Value = 350.000000

Set pocket1 = shapeFactory1.AddNewPocket(sketch6, 20.000000)

pocket1.IsSymmetric = True

part1.Update 

Set reference76 = part1.CreateReferenceFromName("Selection_RSur:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;2:(Brp:(GSMFill.1)))));None:();Cf11:());Pocket.1_ResultOUT;Z0;G4074)")

Set sketch7 = sketches6.Add(reference76)

Dim arrayOfVariantOfDouble3(8)
arrayOfVariantOfDouble3(0) = 0.000000
arrayOfVariantOfDouble3(1) = 4.000000
arrayOfVariantOfDouble3(2) = 0.000000
arrayOfVariantOfDouble3(3) = -1.000000
arrayOfVariantOfDouble3(4) = 0.000000
arrayOfVariantOfDouble3(5) = 0.000000
arrayOfVariantOfDouble3(6) = 0.000000
arrayOfVariantOfDouble3(7) = -0.000000
arrayOfVariantOfDouble3(8) = 1.000000
sketch7.SetAbsoluteAxisData arrayOfVariantOfDouble3

part1.InWorkObject = sketch7

Set factory2D3 = sketch7.OpenEdition()

Set geometricElements12 = sketch7.GeometricElements

Set axis2D3 = geometricElements12.Item("AbsoluteAxis")

Set line2D15 = axis2D3.GetItem("HDirection")

line2D15.ReportName = 9

Set line2D16 = axis2D3.GetItem("VDirection")

line2D16.ReportName = 10

Set point2D11 = factory2D3.CreatePoint(-195.000000, 490.000000)

point2D11.ReportName = 11

Set point2D12 = factory2D3.CreatePoint(-190.000000, 490.000000)

point2D12.ReportName = 12

Set point2D13 = factory2D3.CreatePoint(-200.000000, 490.000000)

point2D13.ReportName = 13

Set circle2D1 = factory2D3.CreateCircle(-195.000000, 490.000000, 5.000000, 6.283185, 9.424778)

circle2D1.CenterPoint = point2D11

circle2D1.ReportName = 14

circle2D1.StartPoint = point2D12

circle2D1.EndPoint = point2D13

Set constraints3 = sketch7.Constraints

Set reference77 = part1.CreateReferenceFromObject(circle2D1)

Set constraint21 = constraints3.AddMonoEltCst(catCstTypeRadius, reference77)

constraint21.Mode = catCstModeDrivingDimension

Set length8 = constraint21.Dimension

length8.Value = 5.000000

Set point2D14 = factory2D3.CreatePoint(-195.000000, 180.000000)

point2D14.ReportName = 15

Set point2D15 = factory2D3.CreatePoint(-200.000000, 180.000000)

point2D15.ReportName = 16

Set point2D16 = factory2D3.CreatePoint(-190.000000, 180.000000)

point2D16.ReportName = 17

Set circle2D2 = factory2D3.CreateCircle(-195.000000, 180.000000, 5.000000, 3.141593, 6.283185)

circle2D2.CenterPoint = point2D14

circle2D2.ReportName = 18

circle2D2.StartPoint = point2D15

circle2D2.EndPoint = point2D16

Set reference78 = part1.CreateReferenceFromObject(circle2D2)

Set constraint22 = constraints3.AddMonoEltCst(catCstTypeRadius, reference78)

constraint22.Mode = catCstModeDrivingDimension

Set length9 = constraint22.Dimension

length9.Value = 5.000000

Set line2D17 = factory2D3.CreateLine(-200.000000, 490.000000, -200.000000, 180.000000)

line2D17.ReportName = 19

line2D17.StartPoint = point2D13

line2D17.EndPoint = point2D15

Set reference79 = part1.CreateReferenceFromObject(line2D17)

Set reference80 = part1.CreateReferenceFromObject(circle2D2)

Set constraint23 = constraints3.AddBiEltCst(catCstTypeTangency, reference79, reference80)

constraint23.Mode = catCstModeDrivingDimension

Set line2D18 = factory2D3.CreateLine(-190.000000, 490.000000, -190.000000, 180.000000)

line2D18.ReportName = 20

line2D18.StartPoint = point2D12

line2D18.EndPoint = point2D16

Set reference81 = part1.CreateReferenceFromObject(line2D18)

Set reference82 = part1.CreateReferenceFromObject(line2D17)

Set constraint24 = constraints3.AddBiEltCst(catCstTypeParallelism, reference81, reference82)

constraint24.Mode = catCstModeDrivingDimension

Set reference83 = part1.CreateReferenceFromObject(line2D17)

Set reference84 = part1.CreateReferenceFromObject(line2D16)

Set constraint25 = constraints3.AddBiEltCst(catCstTypeVerticality, reference83, reference84)

constraint25.Mode = catCstModeDrivingDimension

Set reference85 = part1.CreateReferenceFromObject(line2D18)

Set reference86 = part1.CreateReferenceFromObject(circle2D1)

Set constraint26 = constraints3.AddBiEltCst(catCstTypeTangency, reference85, reference86)

constraint26.Mode = catCstModeDrivingDimension

Set reference87 = part1.CreateReferenceFromObject(line2D18)

Set reference88 = part1.CreateReferenceFromObject(circle2D2)

Set constraint27 = constraints3.AddBiEltCst(catCstTypeTangency, reference87, reference88)

constraint27.Mode = catCstModeDrivingDimension

Set reference89 = part1.CreateReferenceFromObject(line2D18)

Set constraint28 = constraints3.AddMonoEltCst(catCstTypeLength, reference89)

constraint28.Mode = catCstModeDrivingDimension

Set length10 = constraint28.Dimension

length10.Value = 310.000000

Set point2D17 = factory2D3.CreatePoint(-255.000000, 525.000000)

point2D17.ReportName = 21

Set point2D18 = factory2D3.CreatePoint(-250.000000, 525.000000)

point2D18.ReportName = 22

Set point2D19 = factory2D3.CreatePoint(-260.000000, 525.000000)

point2D19.ReportName = 23

Set circle2D3 = factory2D3.CreateCircle(-255.000000, 525.000000, 5.000000, 6.283185, 9.424778)

circle2D3.CenterPoint = point2D17

circle2D3.ReportName = 24

circle2D3.StartPoint = point2D18

circle2D3.EndPoint = point2D19

Set point2D20 = factory2D3.CreatePoint(-255.000000, 300.000000)

point2D20.ReportName = 25

Set point2D21 = factory2D3.CreatePoint(-260.000000, 300.000000)

point2D21.ReportName = 26

Set point2D22 = factory2D3.CreatePoint(-250.000000, 300.000000)

point2D22.ReportName = 27

Set circle2D4 = factory2D3.CreateCircle(-255.000000, 300.000000, 5.000000, 3.141593, 6.283185)

circle2D4.CenterPoint = point2D20

circle2D4.ReportName = 28

circle2D4.StartPoint = point2D21

circle2D4.EndPoint = point2D22

Set line2D19 = factory2D3.CreateLine(-250.000000, 300.000000, -250.000000, 525.000000)

line2D19.ReportName = 29

line2D19.StartPoint = point2D22

line2D19.EndPoint = point2D18

Set reference90 = part1.CreateReferenceFromObject(line2D19)

Set reference91 = part1.CreateReferenceFromObject(circle2D3)

Set constraint29 = constraints3.AddBiEltCst(catCstTypeTangency, reference90, reference91)

constraint29.Mode = catCstModeDrivingDimension

Set line2D20 = factory2D3.CreateLine(-260.000000, 300.000000, -260.000000, 525.000000)

line2D20.ReportName = 30

line2D20.StartPoint = point2D21

line2D20.EndPoint = point2D19

Set reference92 = part1.CreateReferenceFromObject(line2D20)

Set reference93 = part1.CreateReferenceFromObject(circle2D3)

Set constraint30 = constraints3.AddBiEltCst(catCstTypeTangency, reference92, reference93)

constraint30.Mode = catCstModeDrivingDimension

Set reference94 = part1.CreateReferenceFromObject(circle2D3)

Set constraint31 = constraints3.AddMonoEltCst(catCstTypeRadius, reference94)

constraint31.Mode = catCstModeDrivingDimension

Set length11 = constraint31.Dimension

length11.Value = 5.000000

Set reference95 = part1.CreateReferenceFromObject(circle2D4)

Set constraint32 = constraints3.AddMonoEltCst(catCstTypeRadius, reference95)

constraint32.Mode = catCstModeDrivingDimension

Set length12 = constraint32.Dimension

length12.Value = 5.000000

Set reference96 = part1.CreateReferenceFromObject(line2D19)

Set reference97 = part1.CreateReferenceFromObject(circle2D4)

Set constraint33 = constraints3.AddBiEltCst(catCstTypeTangency, reference96, reference97)

constraint33.Mode = catCstModeDrivingDimension

Set reference98 = part1.CreateReferenceFromObject(line2D20)

Set reference99 = part1.CreateReferenceFromObject(circle2D4)

Set constraint34 = constraints3.AddBiEltCst(catCstTypeTangency, reference98, reference99)

constraint34.Mode = catCstModeDrivingDimension

Set reference100 = part1.CreateReferenceFromObject(line2D19)

Set reference101 = part1.CreateReferenceFromObject(line2D16)

Set constraint35 = constraints3.AddBiEltCst(catCstTypeVerticality, reference100, reference101)

constraint35.Mode = catCstModeDrivingDimension

Set reference102 = part1.CreateReferenceFromObject(line2D19)

Set constraint36 = constraints3.AddMonoEltCst(catCstTypeLength, reference102)

constraint36.Mode = catCstModeDrivingDimension

Set length13 = constraint36.Dimension

length13.Value = 225.000000

Set point2D23 = factory2D3.CreatePoint(-225.000000, 510.000000)

point2D23.ReportName = 31

Set point2D24 = factory2D3.CreatePoint(-220.000000, 510.000000)

point2D24.ReportName = 32

Set point2D25 = factory2D3.CreatePoint(-230.000000, 510.000000)

point2D25.ReportName = 33

Set circle2D5 = factory2D3.CreateCircle(-225.000000, 510.000000, 5.000000, 0.000000, 3.141593)

circle2D5.CenterPoint = point2D23

circle2D5.ReportName = 34

circle2D5.StartPoint = point2D24

circle2D5.EndPoint = point2D25

Set point2D26 = factory2D3.CreatePoint(-225.000000, 225.000000)

point2D26.ReportName = 35

Set point2D27 = factory2D3.CreatePoint(-230.000000, 225.000000)

point2D27.ReportName = 36

Set point2D28 = factory2D3.CreatePoint(-220.000000, 225.000000)

point2D28.ReportName = 37

Set circle2D6 = factory2D3.CreateCircle(-225.000000, 225.000000, 5.000000, 3.141593, 6.283185)

circle2D6.CenterPoint = point2D26

circle2D6.ReportName = 38

circle2D6.StartPoint = point2D27

circle2D6.EndPoint = point2D28

Set reference103 = part1.CreateReferenceFromObject(circle2D6)

Set constraint37 = constraints3.AddMonoEltCst(catCstTypeRadius, reference103)

constraint37.Mode = catCstModeDrivingDimension

Set length14 = constraint37.Dimension

length14.Value = 5.000000

Set reference104 = part1.CreateReferenceFromObject(circle2D5)

Set constraint38 = constraints3.AddMonoEltCst(catCstTypeRadius, reference104)

constraint38.Mode = catCstModeDrivingDimension

Set length15 = constraint38.Dimension

length15.Value = 5.000000

Set point2D29 = factory2D3.CreatePoint(-220.000000, 225.000000)

point2D29.ReportName = 39

Set line2D21 = factory2D3.CreateLine(-220.000000, 225.000000, -220.000000, 510.000000)

line2D21.ReportName = 40

line2D21.StartPoint = point2D29

line2D21.EndPoint = point2D24

Set reference105 = part1.CreateReferenceFromObject(point2D29)

Set reference106 = part1.CreateReferenceFromObject(circle2D6)

Set constraint39 = constraints3.AddBiEltCst(catCstTypeOn, reference105, reference106)

constraint39.Mode = catCstModeDrivingDimension

Set reference107 = part1.CreateReferenceFromObject(line2D21)

Set reference108 = part1.CreateReferenceFromObject(circle2D5)

Set constraint40 = constraints3.AddBiEltCst(catCstTypeTangency, reference107, reference108)

constraint40.Mode = catCstModeDrivingDimension

Set point2D30 = factory2D3.CreatePoint(-230.000000, 225.000000)

point2D30.ReportName = 41

Set point2D31 = factory2D3.CreatePoint(-230.000000, 510.000000)

point2D31.ReportName = 42

Set line2D22 = factory2D3.CreateLine(-230.000000, 225.000000, -230.000000, 510.000000)

line2D22.ReportName = 43

line2D22.StartPoint = point2D30

line2D22.EndPoint = point2D31

Set reference109 = part1.CreateReferenceFromObject(point2D30)

Set reference110 = part1.CreateReferenceFromObject(circle2D6)

Set constraint41 = constraints3.AddBiEltCst(catCstTypeOn, reference109, reference110)

constraint41.Mode = catCstModeDrivingDimension

Set reference111 = part1.CreateReferenceFromObject(line2D22)

Set reference112 = part1.CreateReferenceFromObject(circle2D6)

Set constraint42 = constraints3.AddBiEltCst(catCstTypeTangency, reference111, reference112)

constraint42.Mode = catCstModeDrivingDimension

Set reference113 = part1.CreateReferenceFromObject(line2D22)

Set reference114 = part1.CreateReferenceFromObject(circle2D5)

Set constraint43 = constraints3.AddBiEltCst(catCstTypeTangency, reference113, reference114)

constraint43.Mode = catCstModeDrivingDimension

Set reference115 = part1.CreateReferenceFromObject(point2D31)

Set reference116 = part1.CreateReferenceFromObject(circle2D5)

Set constraint44 = constraints3.AddBiEltCst(catCstTypeOn, reference115, reference116)

constraint44.Mode = catCstModeDrivingDimension

Set reference117 = part1.CreateReferenceFromObject(line2D21)

Set reference118 = part1.CreateReferenceFromObject(circle2D6)

Set constraint45 = constraints3.AddBiEltCst(catCstTypeTangency, reference117, reference118)

constraint45.Mode = catCstModeDrivingDimension

Set reference119 = part1.CreateReferenceFromObject(line2D21)

Set reference120 = part1.CreateReferenceFromObject(line2D16)

Set constraint46 = constraints3.AddBiEltCst(catCstTypeVerticality, reference119, reference120)

constraint46.Mode = catCstModeDrivingDimension

Set reference121 = part1.CreateReferenceFromObject(line2D21)

Set constraint47 = constraints3.AddMonoEltCst(catCstTypeLength, reference121)

constraint47.Mode = catCstModeDrivingDimension

Set length16 = constraint47.Dimension

length16.Value = 285.000000

Set reference122 = part1.CreateReferenceFromObject(line2D22)

Set reference123 = part1.CreateReferenceFromObject(point2D25)

Set constraint48 = constraints3.AddBiEltCst(catCstTypeOn, reference122, reference123)

constraint48.Mode = catCstModeDrivingDimension

Set reference124 = part1.CreateReferenceFromObject(line2D21)

Set reference125 = part1.CreateReferenceFromObject(point2D28)

Set constraint49 = constraints3.AddBiEltCst(catCstTypeOn, reference124, reference125)

constraint49.Mode = catCstModeDrivingDimension

Set reference126 = part1.CreateReferenceFromObject(line2D22)

Set reference127 = part1.CreateReferenceFromObject(point2D27)

Set constraint50 = constraints3.AddBiEltCst(catCstTypeOn, reference126, reference127)

constraint50.Mode = catCstModeDrivingDimension

Set point2D32 = factory2D3.CreatePoint(-285.000000, 550.000000)

point2D32.ReportName = 44

Set point2D33 = factory2D3.CreatePoint(-280.000000, 550.000000)

point2D33.ReportName = 45

Set point2D34 = factory2D3.CreatePoint(-290.000000, 550.000000)

point2D34.ReportName = 46

Set circle2D7 = factory2D3.CreateCircle(-285.000000, 550.000000, 5.000000, 0.000000, 3.141593)

circle2D7.CenterPoint = point2D32

circle2D7.ReportName = 47

circle2D7.StartPoint = point2D33

circle2D7.EndPoint = point2D34

Set point2D35 = factory2D3.CreatePoint(-285.000000, 350.000000)

point2D35.ReportName = 48

Set point2D36 = factory2D3.CreatePoint(-290.000000, 350.000000)

point2D36.ReportName = 49

Set point2D37 = factory2D3.CreatePoint(-280.000000, 350.000000)

point2D37.ReportName = 50

Set circle2D8 = factory2D3.CreateCircle(-285.000000, 350.000000, 5.000000, 3.141593, 6.283185)

circle2D8.CenterPoint = point2D35

circle2D8.ReportName = 51

circle2D8.StartPoint = point2D36

circle2D8.EndPoint = point2D37

Set reference128 = part1.CreateReferenceFromObject(circle2D8)

Set constraint51 = constraints3.AddMonoEltCst(catCstTypeRadius, reference128)

constraint51.Mode = catCstModeDrivingDimension

Set length17 = constraint51.Dimension

length17.Value = 5.000000

Set reference129 = part1.CreateReferenceFromObject(circle2D7)

Set constraint52 = constraints3.AddMonoEltCst(catCstTypeRadius, reference129)

constraint52.Mode = catCstModeDrivingDimension

Set length18 = constraint52.Dimension

length18.Value = 5.000000

Set line2D23 = factory2D3.CreateLine(-280.000000, 350.000000, -280.000000, 550.000000)

line2D23.ReportName = 52

line2D23.StartPoint = point2D37

line2D23.EndPoint = point2D33

Set reference130 = part1.CreateReferenceFromObject(line2D23)

Set reference131 = part1.CreateReferenceFromObject(circle2D7)

Set constraint53 = constraints3.AddBiEltCst(catCstTypeTangency, reference130, reference131)

constraint53.Mode = catCstModeDrivingDimension

Set line2D24 = factory2D3.CreateLine(-290.000000, 350.000000, -290.000000, 550.000000)

line2D24.ReportName = 53

line2D24.StartPoint = point2D36

line2D24.EndPoint = point2D34

Set reference132 = part1.CreateReferenceFromObject(line2D24)

Set reference133 = part1.CreateReferenceFromObject(circle2D7)

Set constraint54 = constraints3.AddBiEltCst(catCstTypeTangency, reference132, reference133)

constraint54.Mode = catCstModeDrivingDimension

Set reference134 = part1.CreateReferenceFromObject(line2D23)

Set reference135 = part1.CreateReferenceFromObject(line2D16)

Set constraint55 = constraints3.AddBiEltCst(catCstTypeVerticality, reference134, reference135)

constraint55.Mode = catCstModeDrivingDimension

Set reference136 = part1.CreateReferenceFromObject(line2D24)

Set reference137 = part1.CreateReferenceFromObject(circle2D8)

Set constraint56 = constraints3.AddBiEltCst(catCstTypeTangency, reference136, reference137)

constraint56.Mode = catCstModeDrivingDimension

Set reference138 = part1.CreateReferenceFromObject(line2D23)

Set constraint57 = constraints3.AddMonoEltCst(catCstTypeLength, reference138)

constraint57.Mode = catCstModeDrivingDimension

Set length19 = constraint57.Dimension

length19.Value = 200.000000

Set reference139 = part1.CreateReferenceFromObject(line2D24)

Set reference140 = part1.CreateReferenceFromObject(line2D20)

Set constraint58 = constraints3.AddBiEltCst(catCstTypeDistance, reference139, reference140)

constraint58.Mode = catCstModeDrivingDimension

Set length20 = constraint58.Dimension

length20.Value = 30.000000

Set reference141 = part1.CreateReferenceFromObject(line2D19)

Set reference142 = part1.CreateReferenceFromObject(line2D21)

Set constraint59 = constraints3.AddBiEltCst(catCstTypeDistance, reference141, reference142)

constraint59.Mode = catCstModeDrivingDimension

Set length21 = constraint59.Dimension

length21.Value = 30.000000

Set reference143 = part1.CreateReferenceFromObject(line2D21)

Set reference144 = part1.CreateReferenceFromObject(line2D18)

Set constraint60 = constraints3.AddBiEltCst(catCstTypeDistance, reference143, reference144)

constraint60.Mode = catCstModeDrivingDimension

Set length22 = constraint60.Dimension

length22.Value = 30.000000

Set reference145 = part1.CreateReferenceFromObject(point2D14)

Set reference146 = part1.CreateReferenceFromObject(line2D15)

Set constraint61 = constraints3.AddBiEltCst(catCstTypeDistance, reference145, reference146)

constraint61.Mode = catCstModeDrivingDimension

Set length23 = constraint61.Dimension

length23.Value = 180.000000

Set reference147 = part1.CreateReferenceFromObject(line2D18)

Set reference148 = part1.CreateReferenceFromObject(line2D16)

Set constraint62 = constraints3.AddBiEltCst(catCstTypeDistance, reference147, reference148)

constraint62.Mode = catCstModeDrivingDimension

Set length24 = constraint62.Dimension

length24.Value = 190.000000

Set reference149 = part1.CreateReferenceFromObject(point2D26)

Set reference150 = part1.CreateReferenceFromObject(line2D15)

Set constraint63 = constraints3.AddBiEltCst(catCstTypeDistance, reference149, reference150)

constraint63.Mode = catCstModeDrivingDimension

Set length25 = constraint63.Dimension

length25.Value = 225.000000

Set reference151 = part1.CreateReferenceFromObject(point2D20)

Set reference152 = part1.CreateReferenceFromObject(line2D15)

Set constraint64 = constraints3.AddBiEltCst(catCstTypeDistance, reference151, reference152)

constraint64.Mode = catCstModeDrivingDimension

Set length26 = constraint64.Dimension

length26.Value = 300.000000

Set reference153 = part1.CreateReferenceFromObject(point2D35)

Set reference154 = part1.CreateReferenceFromObject(line2D15)

Set constraint65 = constraints3.AddBiEltCst(catCstTypeDistance, reference153, reference154)

constraint65.Mode = catCstModeDrivingDimension

Set length27 = constraint65.Dimension

length27.Value = 350.000000

sketch7.CloseEdition 

part1.InWorkObject = sketch7

part1.Update 

Set pocket2 = shapeFactory1.AddNewPocket(sketch7, 20.000000)

pocket2.IsSymmetric = True

part1.Update 

part1.InWorkObject = sketch7

Set factory2D3 = sketch7.OpenEdition()

sketch7.CloseEdition 

part1.InWorkObject = pocket2

part1.Update 

part1.InWorkObject = sketch7

Set factory2D3 = sketch7.OpenEdition()

point2D11.SetData -220.000000, 505.000000

point2D12.SetData -215.000000, 505.000000

point2D13.SetData -225.000000, 505.000000

circle2D1.SetData -220.000000, 505.000000, 5.000000

length8.Value = 5.000000

point2D14.SetData -220.000000, 180.000000

point2D15.SetData -225.000000, 180.000000

point2D16.SetData -215.000000, 180.000000

circle2D2.SetData -220.000000, 180.000000, 5.000000

length9.Value = 5.000000

line2D17.SetData -225.000000, -33.811806, 0.000000, -1.000000

line2D18.SetData -215.000000, 399.420047, 0.000000, -1.000000

length10.Value = 325.000000

point2D17.SetData -270.000000, 540.000000

point2D18.SetData -265.000000, 540.000000

point2D19.SetData -275.000000, 540.000000

circle2D3.SetData -270.000000, 540.000000, 5.000000

point2D20.SetData -270.000000, 315.000000

point2D21.SetData -275.000000, 315.000000

point2D22.SetData -265.000000, 315.000000

circle2D4.SetData -270.000000, 315.000000, 5.000000

line2D19.SetData -265.000000, 351.614367, 0.000000, 1.000000

line2D20.SetData -275.000000, -279.498859, 0.000000, 1.000000

length11.Value = 5.000000

length12.Value = 5.000000

length13.Value = 225.000000

point2D23.SetData -245.000000, 525.000000

point2D24.SetData -240.000000, 525.000000

point2D25.SetData -250.000000, 525.000000

circle2D5.SetData -245.000000, 525.000000, 5.000000

point2D26.SetData -245.000000, 250.000000

point2D27.SetData -250.000000, 250.000000

point2D28.SetData -240.000000, 250.000000

circle2D6.SetData -245.000000, 250.000000, 5.000000

length14.Value = 5.000000

length15.Value = 5.000000

point2D29.SetData -240.000000, 250.000000

line2D21.SetData -240.000000, -9.852564, 0.000000, 1.000000

point2D30.SetData -250.000000, 250.000000

point2D31.SetData -250.000000, 525.000000

line2D22.SetData -250.000000, -99.518724, 0.000000, 1.000000

length16.Value = 275.000000

point2D32.SetData -295.000000, 555.000000

point2D33.SetData -290.000000, 555.000000

point2D34.SetData -300.000000, 555.000000

circle2D7.SetData -295.000000, 555.000000, 5.000000

point2D35.SetData -295.000000, 375.000000

point2D36.SetData -300.000000, 375.000000

point2D37.SetData -290.000000, 375.000000

circle2D8.SetData -295.000000, 375.000000, 5.000000

length17.Value = 5.000000

length18.Value = 5.000000

line2D23.SetData -290.000000, 237.794278, 0.000000, 1.000000

line2D24.SetData -300.000000, 42.891542, 0.000000, 1.000000

length19.Value = 180.000000

length20.Value = 25.000000

length21.Value = 25.000000

length22.Value = 25.000000

length23.Value = 180.000000

length24.Value = 215.000000

length25.Value = 250.000000

length26.Value = 315.000000

length27.Value = 375.000000

sketch7.CloseEdition 

part1.InWorkObject = pocket2

part1.Update 

part1.InWorkObject = sketch7

Set factory2D3 = sketch7.OpenEdition()

point2D11.SetData -220.000000, 525.000000

point2D12.SetData -215.000000, 525.000000

point2D13.SetData -225.000000, 525.000000

circle2D1.SetData -220.000000, 525.000000, 5.000000

length8.Value = 5.000000

point2D14.SetData -220.000000, 225.000000

point2D15.SetData -225.000000, 225.000000

point2D16.SetData -215.000000, 225.000000

circle2D2.SetData -220.000000, 225.000000, 5.000000

length9.Value = 5.000000

line2D17.SetData -225.000000, 11.188194, 0.000000, -1.000000

line2D18.SetData -215.000000, 409.420047, 0.000000, -1.000000

length10.Value = 300.000000

point2D17.SetData -270.000000, 550.000000

point2D18.SetData -265.000000, 550.000000

point2D19.SetData -275.000000, 550.000000

circle2D3.SetData -270.000000, 550.000000, 5.000000

point2D20.SetData -270.000000, 325.000000

point2D21.SetData -275.000000, 325.000000

point2D22.SetData -265.000000, 325.000000

circle2D4.SetData -270.000000, 325.000000, 5.000000

line2D19.SetData -265.000000, 361.614367, 0.000000, 1.000000

line2D20.SetData -275.000000, -279.498859, 0.000000, 1.000000

length11.Value = 5.000000

length12.Value = 5.000000

length13.Value = 225.000000

point2D23.SetData -245.000000, 542.200000

point2D24.SetData -240.000000, 542.200000

point2D25.SetData -250.000000, 542.200000

circle2D5.SetData -245.000000, 542.200000, 5.000000

point2D26.SetData -245.000000, 275.000000

point2D27.SetData -250.000000, 275.000000

point2D28.SetData -240.000000, 275.000000

circle2D6.SetData -245.000000, 275.000000, 5.000000

length14.Value = 5.000000

length15.Value = 5.000000

point2D29.SetData -240.000000, 275.000000

line2D21.SetData -240.000000, 0.147436, 0.000000, 1.000000

point2D30.SetData -250.000000, 275.000000

point2D31.SetData -250.000000, 542.200000

line2D22.SetData -250.000000, -78.418724, 0.000000, 1.000000

length16.Value = 267.200000

point2D32.SetData -295.000000, 560.000000

point2D33.SetData -290.000000, 560.000000

point2D34.SetData -300.000000, 560.000000

circle2D7.SetData -295.000000, 560.000000, 5.000000

length18.Value = 5.000000

line2D23.SetData -290.000000, 242.794278, 0.000000, 1.000000

line2D24.SetData -300.000000, 42.891542, 0.000000, 1.000000

length19.Value = 185.000000

length20.Value = 25.000000

length21.Value = 25.000000

length22.Value = 25.000000

length23.Value = 225.000000

length24.Value = 215.000000

length25.Value = 275.000000

length26.Value = 325.000000

length27.Value = 375.000000

sketch7.CloseEdition 

part1.InWorkObject = pocket2

part1.Update 

Set reference155 = part1.CreateReferenceFromName("")

Set constRadEdgeFillet1 = shapeFactory1.AddNewSolidEdgeFilletWithConstantRadius(reference155, catTangencyFilletEdgePropagation, 5.000000)

Set reference156 = part1.CreateReferenceFromBRepName("TgtEdge:(GeneratedEdges;MfIE_R20GA;TgtPropagationFillet;FirstOperands:(Pocket.1);SecondOperands:();InitEdges:(REdge:(Edge:(Face:(Brp:(Pocket.1;0:(Brp:(Sketch.8;8)));None:();Cf11:());Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;9)))))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithTemporaryBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)))", pocket2)

constRadEdgeFillet1.AddObjectToFillet reference156

constRadEdgeFillet1.EdgePropagation = catTangencyFilletEdgePropagation

Set parameters1 = part1.Parameters

Set length28 = parameters1.Item("RW-zero\Body.8\EdgeFillet.1\CstEdgeRibbon.1\Radius")

length28.Value = 75.000000

part1.Update 

Set reference157 = part1.CreateReferenceFromName("")

Set constRadEdgeFillet2 = shapeFactory1.AddNewSolidEdgeFilletWithConstantRadius(reference157, catTangencyFilletEdgePropagation, 75.000000)

Set reference158 = part1.CreateReferenceFromBRepName("TgtEdge:(GeneratedEdges;MfIE_R20GA;TgtPropagationFillet;FirstOperands:(Pocket.1);SecondOperands:();InitEdges:(REdge:(Edge:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;10)))))));None:();Cf11:());Face:(Brp:(Pocket.1;0:(Brp:(Sketch.8;8)));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithTemporaryBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)))", constRadEdgeFillet1)

constRadEdgeFillet2.AddObjectToFillet reference158

constRadEdgeFillet2.EdgePropagation = catTangencyFilletEdgePropagation

part1.Update 

Set reference159 = part1.CreateReferenceFromName("")

Set constRadEdgeFillet3 = shapeFactory1.AddNewSolidEdgeFilletWithConstantRadius(reference159, catTangencyFilletEdgePropagation, 75.000000)

Set reference160 = part1.CreateReferenceFromBRepName("TgtEdge:(GeneratedEdges;MfIE_R20GA;TgtPropagationFillet;FirstOperands:(Pocket.1);SecondOperands:();InitEdges:(REdge:(Edge:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;7)))))));None:();Cf11:());Face:(Brp:(Pocket.1;0:(Brp:(Sketch.8;14)));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithTemporaryBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)))", constRadEdgeFillet2)

constRadEdgeFillet3.AddObjectToFillet reference160

constRadEdgeFillet3.EdgePropagation = catTangencyFilletEdgePropagation

part1.Update 

Set reference161 = part1.CreateReferenceFromName("")

Set constRadEdgeFillet4 = shapeFactory1.AddNewSolidEdgeFilletWithConstantRadius(reference161, catTangencyFilletEdgePropagation, 75.000000)

Set reference162 = part1.CreateReferenceFromBRepName("TgtEdge:(GeneratedEdges;MfIE_R20GA;TgtPropagationFillet;FirstOperands:(CloseSurface.1);SecondOperands:();InitEdges:(REdge:(Edge:(Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;7)))))));None:();Cf11:());Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;9)))))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithTemporaryBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)))", constRadEdgeFillet3)

constRadEdgeFillet4.AddObjectToFillet reference162

constRadEdgeFillet4.EdgePropagation = catTangencyFilletEdgePropagation

part1.Update 

length28.Value = 50.000000

part1.Update 

Set parameters2 = part1.Parameters

Set length29 = parameters2.Item("RW-zero\Body.8\EdgeFillet.2\CstEdgeRibbon.2\Radius")

length29.Value = 50.000000

part1.Update 

Set parameters3 = part1.Parameters

Set length30 = parameters3.Item("RW-zero\Body.8\EdgeFillet.3\CstEdgeRibbon.3\Radius")

length30.Value = 50.000000

part1.Update 

Set parameters4 = part1.Parameters

Set length31 = parameters4.Item("RW-zero\Body.8\EdgeFillet.4\CstEdgeRibbon.4\Radius")

length31.Value = 50.000000

part1.Update 

Set reference163 = part1.CreateReferenceFromName("")

Set constRadEdgeFillet5 = shapeFactory1.AddNewSolidEdgeFilletWithConstantRadius(reference163, catTangencyFilletEdgePropagation, 75.000000)

Set reference164 = part1.CreateReferenceFromBRepName("TgtEdge:(GeneratedEdges;MfIE_R20GA;TgtPropagationFillet;FirstOperands:(Pocket.1);SecondOperands:();InitEdges:(REdge:(Edge:(Face:(Brp:(Pocket.1;0:(Brp:(Sketch.8;14)));None:();Cf11:());Face:(Brp:(CloseSurface.1;(Brp:(GSMExtrude.1;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;5)))))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithTemporaryBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)))", constRadEdgeFillet4)

constRadEdgeFillet5.AddObjectToFillet reference164

constRadEdgeFillet5.EdgePropagation = catTangencyFilletEdgePropagation

Set parameters5 = part1.Parameters

Set length32 = parameters5.Item("RW-zero\Body.8\EdgeFillet.5\CstEdgeRibbon.5\Radius")

length32.Value = 50.000000



Set reference165 = part1.CreateReferenceFromObject(hybridShapePlaneOffset1)

Set mirror1 = shapeFactory1.AddNewMirror(reference165)



part1.Update 

End Sub
