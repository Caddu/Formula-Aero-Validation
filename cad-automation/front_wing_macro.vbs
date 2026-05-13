Language="VBSCRIPT"

Sub CATMain()

Set partDocument1 = CATIA.ActiveDocument

Set part1 = partDocument1.Part

Set hybridBodies1 = part1.HybridBodies

Set hybridBody1 = hybridBodies1.Add()

part1.Update 

Set hybridShapeFactory1 = part1.HybridShapeFactory

Set hybridShapeDirection1 = hybridShapeFactory1.AddNewDirectionByCoord(0.000000, 0.000000, 0.000000)

Set bodies1 = part1.Bodies

Set body1 = bodies1.Item("Main Element")

Set sketches1 = body1.Sketches

Set sketch1 = sketches1.Item("Sketch.1")

Set reference1 = part1.CreateReferenceFromObject(sketch1)

Set hybridShapeExtrude1 = hybridShapeFactory1.AddNewExtrude(reference1, -75.000000, 0.000000, hybridShapeDirection1)

hybridShapeExtrude1.SymmetricalExtension = 0

hybridBody1.AppendHybridShape hybridShapeExtrude1

part1.InWorkObject = hybridShapeExtrude1

part1.Update 

Set hybridShapeDirection2 = hybridShapeFactory1.AddNewDirectionByCoord(0.000000, 0.000000, 0.000000)

Set body2 = bodies1.Item("Main Element_EXT")

Set sketches2 = body2.Sketches

Set sketch2 = sketches2.Item("Sketch.4")

Set reference2 = part1.CreateReferenceFromObject(sketch2)

Set hybridShapeExtrude2 = hybridShapeFactory1.AddNewExtrude(reference2, 75.000000, 0.000000, hybridShapeDirection2)

hybridShapeExtrude2.SymmetricalExtension = 0

hybridBody1.AppendHybridShape hybridShapeExtrude2

part1.InWorkObject = hybridShapeExtrude2

part1.Update 

Set reference3 = part1.CreateReferenceFromBRepName("BorderREdge:(BEdge:(Brp:(GSMExtrude.1;2:(Brp:(Sketch.1;1)));None:(Limits1:();Limits2:();-1);Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)", hybridShapeExtrude1)

Set hybridShapeExtract1 = hybridShapeFactory1.AddNewExtract(reference3)

hybridShapeExtract1.PropagationType = 2

hybridShapeExtract1.ComplementaryExtract = False

hybridShapeExtract1.IsFederated = False

hybridBody1.AppendHybridShape hybridShapeExtract1

part1.InWorkObject = hybridShapeExtract1

part1.Update 

Set reference4 = part1.CreateReferenceFromBRepName("BorderREdge:(BEdge:(Brp:(GSMExtrude.2;2:(Brp:(Sketch.4;1)));None:(Limits1:();Limits2:();-1);Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)", hybridShapeExtrude2)

Set hybridShapeExtract2 = hybridShapeFactory1.AddNewExtract(reference4)

hybridShapeExtract2.PropagationType = 2

hybridShapeExtract2.ComplementaryExtract = False

hybridShapeExtract2.IsFederated = False

hybridBody1.AppendHybridShape hybridShapeExtract2

part1.InWorkObject = hybridShapeExtract2

part1.Update 

Set hybridShapeDirection3 = hybridShapeFactory1.AddNewDirectionByCoord(1.000000, 2.000000, 3.000000)

Set reference5 = part1.CreateReferenceFromObject(hybridShapeExtract1)

Set hybridShapeExtremum1 = hybridShapeFactory1.AddNewExtremum(reference5, hybridShapeDirection3, 1)

hybridBody1.AppendHybridShape hybridShapeExtremum1

part1.InWorkObject = hybridShapeExtremum1

part1.Update 

Set hybridShapeDirection4 = hybridShapeFactory1.AddNewDirectionByCoord(1.000000, 2.000000, 3.000000)

Set reference6 = part1.CreateReferenceFromObject(hybridShapeExtract2)

Set hybridShapeExtremum2 = hybridShapeFactory1.AddNewExtremum(reference6, hybridShapeDirection4, 1)

hybridBody1.AppendHybridShape hybridShapeExtremum2

part1.InWorkObject = hybridShapeExtremum2

part1.Update 

Set hybridShapeBlend1 = hybridShapeFactory1.AddNewBlend()

hybridShapeBlend1.Coupling = 1

Set reference7 = part1.CreateReferenceFromObject(hybridShapeExtract1)

hybridShapeBlend1.SetCurve 1, reference7

hybridShapeBlend1.SetOrientation 1, 1

Set reference8 = part1.CreateReferenceFromObject(hybridShapeExtremum1)

hybridShapeBlend1.SetClosingPoint 1, reference8

Set reference9 = part1.CreateReferenceFromObject(hybridShapeExtract2)

hybridShapeBlend1.SetCurve 2, reference9

hybridShapeBlend1.SetOrientation 2, 1

Set reference10 = part1.CreateReferenceFromObject(hybridShapeExtremum2)

hybridShapeBlend1.SetClosingPoint 2, reference10

hybridShapeBlend1.SmoothAngleThresholdActivity = False

hybridShapeBlend1.SmoothDeviationActivity = False

hybridShapeBlend1.RuledDevelopableSurface = False

hybridBody1.AppendHybridShape hybridShapeBlend1

part1.InWorkObject = hybridShapeBlend1

part1.Update 

Set hybridBody2 = hybridBodies1.Add()

part1.Update 

Set hybridShapeDirection5 = hybridShapeFactory1.AddNewDirectionByCoord(0.000000, 0.000000, 0.000000)

Set body3 = bodies1.Item("Second Element")

Set sketches3 = body3.Sketches

Set sketch3 = sketches3.Item("Sketch.2")

Set reference11 = part1.CreateReferenceFromObject(sketch3)

Set hybridShapeExtrude3 = hybridShapeFactory1.AddNewExtrude(reference11, -75.000000, 0.000000, hybridShapeDirection5)

hybridShapeExtrude3.SymmetricalExtension = 0

hybridBody2.AppendHybridShape hybridShapeExtrude3

part1.InWorkObject = hybridShapeExtrude3

part1.Update 

Set hybridShapeDirection6 = hybridShapeFactory1.AddNewDirectionByCoord(0.000000, 0.000000, 0.000000)

Set body4 = bodies1.Item("Second Element_EXT")

Set sketches4 = body4.Sketches

Set sketch4 = sketches4.Item("Sketch.5")

Set reference12 = part1.CreateReferenceFromObject(sketch4)

Set hybridShapeExtrude4 = hybridShapeFactory1.AddNewExtrude(reference12, 75.000000, 0.000000, hybridShapeDirection6)

hybridShapeExtrude4.SymmetricalExtension = 0

hybridBody2.AppendHybridShape hybridShapeExtrude4

part1.InWorkObject = hybridShapeExtrude4

part1.Update 

Set reference13 = part1.CreateReferenceFromBRepName("BorderREdge:(BEdge:(Brp:(GSMExtrude.3;2:(Brp:(Sketch.2;1)));None:(Limits1:();Limits2:();-1);Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)", hybridShapeExtrude3)

Set hybridShapeExtract3 = hybridShapeFactory1.AddNewExtract(reference13)

hybridShapeExtract3.PropagationType = 2

hybridShapeExtract3.ComplementaryExtract = False

hybridShapeExtract3.IsFederated = False

hybridBody2.AppendHybridShape hybridShapeExtract3

part1.InWorkObject = hybridShapeExtract3

part1.Update 

Set reference14 = part1.CreateReferenceFromBRepName("BorderREdge:(BEdge:(Brp:(GSMExtrude.4;2:(Brp:(Sketch.5;1)));None:(Limits1:();Limits2:();-1);Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)", hybridShapeExtrude4)

Set hybridShapeExtract4 = hybridShapeFactory1.AddNewExtract(reference14)

hybridShapeExtract4.PropagationType = 2

hybridShapeExtract4.ComplementaryExtract = False

hybridShapeExtract4.IsFederated = False

hybridBody2.AppendHybridShape hybridShapeExtract4

part1.InWorkObject = hybridShapeExtract4

part1.Update 

Set hybridShapeDirection7 = hybridShapeFactory1.AddNewDirectionByCoord(1.000000, 2.000000, 3.000000)

Set reference15 = part1.CreateReferenceFromObject(hybridShapeExtract3)

Set hybridShapeExtremum3 = hybridShapeFactory1.AddNewExtremum(reference15, hybridShapeDirection7, 1)

hybridBody2.AppendHybridShape hybridShapeExtremum3

part1.InWorkObject = hybridShapeExtremum3

part1.Update 

Set hybridShapeDirection8 = hybridShapeFactory1.AddNewDirectionByCoord(1.000000, 2.000000, 3.000000)

Set reference16 = part1.CreateReferenceFromObject(hybridShapeExtract4)

Set hybridShapeExtremum4 = hybridShapeFactory1.AddNewExtremum(reference16, hybridShapeDirection8, 1)

hybridBody2.AppendHybridShape hybridShapeExtremum4

part1.InWorkObject = hybridShapeExtremum4

part1.Update 

Set hybridShapeBlend2 = hybridShapeFactory1.AddNewBlend()

hybridShapeBlend2.Coupling = 1

Set reference17 = part1.CreateReferenceFromObject(hybridShapeExtract3)

hybridShapeBlend2.SetCurve 1, reference17

hybridShapeBlend2.SetOrientation 1, 1

Set reference18 = part1.CreateReferenceFromObject(hybridShapeExtremum3)

hybridShapeBlend2.SetClosingPoint 1, reference18

Set reference19 = part1.CreateReferenceFromObject(hybridShapeExtract4)

hybridShapeBlend2.SetCurve 2, reference19

hybridShapeBlend2.SetOrientation 2, 1

Set reference20 = part1.CreateReferenceFromObject(hybridShapeExtremum4)

hybridShapeBlend2.SetClosingPoint 2, reference20

hybridShapeBlend2.SmoothAngleThresholdActivity = False

hybridShapeBlend2.SmoothDeviationActivity = False

hybridShapeBlend2.RuledDevelopableSurface = False

hybridBody2.AppendHybridShape hybridShapeBlend2

part1.InWorkObject = hybridShapeBlend2

part1.Update 

Set hybridBody3 = hybridBodies1.Add()

part1.Update 

Set hybridShapeDirection9 = hybridShapeFactory1.AddNewDirectionByCoord(0.000000, 0.000000, 0.000000)

Set body5 = bodies1.Item("Third Element")

Set sketches5 = body5.Sketches

Set sketch5 = sketches5.Item("Sketch.3")

Set reference21 = part1.CreateReferenceFromObject(sketch5)

Set hybridShapeExtrude5 = hybridShapeFactory1.AddNewExtrude(reference21, -75.000000, 0.000000, hybridShapeDirection9)

hybridShapeExtrude5.SymmetricalExtension = 0

hybridBody3.AppendHybridShape hybridShapeExtrude5

part1.InWorkObject = hybridShapeExtrude5

part1.Update 

Set hybridShapeDirection10 = hybridShapeFactory1.AddNewDirectionByCoord(0.000000, 0.000000, 0.000000)

Set body6 = bodies1.Item("Third Element_EXT")

Set sketches6 = body6.Sketches

Set sketch6 = sketches6.Item("Sketch.6")

Set reference22 = part1.CreateReferenceFromObject(sketch6)

Set hybridShapeExtrude6 = hybridShapeFactory1.AddNewExtrude(reference22, 75.000000, 0.000000, hybridShapeDirection10)

hybridShapeExtrude6.SymmetricalExtension = 0

hybridBody3.AppendHybridShape hybridShapeExtrude6

part1.InWorkObject = hybridShapeExtrude6

part1.Update 

Set reference23 = part1.CreateReferenceFromBRepName("BorderREdge:(BEdge:(Brp:(GSMExtrude.5;2:(Brp:(Sketch.3;1)));None:(Limits1:();Limits2:();-1);Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)", hybridShapeExtrude5)

Set hybridShapeExtract5 = hybridShapeFactory1.AddNewExtract(reference23)

hybridShapeExtract5.PropagationType = 2

hybridShapeExtract5.ComplementaryExtract = False

hybridShapeExtract5.IsFederated = False

hybridBody3.AppendHybridShape hybridShapeExtract5

part1.InWorkObject = hybridShapeExtract5

part1.Update 

Set reference24 = part1.CreateReferenceFromBRepName("BorderREdge:(BEdge:(Brp:(GSMExtrude.6;2:(Brp:(Sketch.6;1)));None:(Limits1:();Limits2:();-1);Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)", hybridShapeExtrude6)

Set hybridShapeExtract6 = hybridShapeFactory1.AddNewExtract(reference24)

hybridShapeExtract6.PropagationType = 2

hybridShapeExtract6.ComplementaryExtract = False

hybridShapeExtract6.IsFederated = False

hybridBody3.AppendHybridShape hybridShapeExtract6

part1.InWorkObject = hybridShapeExtract6

part1.Update 

Set hybridShapeDirection11 = hybridShapeFactory1.AddNewDirectionByCoord(1.000000, 2.000000, 3.000000)

Set reference25 = part1.CreateReferenceFromObject(hybridShapeExtract5)

Set hybridShapeExtremum5 = hybridShapeFactory1.AddNewExtremum(reference25, hybridShapeDirection11, 1)

hybridBody3.AppendHybridShape hybridShapeExtremum5

part1.InWorkObject = hybridShapeExtremum5

part1.Update 

Set hybridShapeDirection12 = hybridShapeFactory1.AddNewDirectionByCoord(1.000000, 2.000000, 3.000000)

Set reference26 = part1.CreateReferenceFromObject(hybridShapeExtract6)

Set hybridShapeExtremum6 = hybridShapeFactory1.AddNewExtremum(reference26, hybridShapeDirection12, 1)

hybridBody3.AppendHybridShape hybridShapeExtremum6

part1.InWorkObject = hybridShapeExtremum6

part1.Update 

Set hybridShapeBlend3 = hybridShapeFactory1.AddNewBlend()

hybridShapeBlend3.Coupling = 1

Set reference27 = part1.CreateReferenceFromObject(hybridShapeExtract5)

hybridShapeBlend3.SetCurve 1, reference27

hybridShapeBlend3.SetOrientation 1, 1

Set reference28 = part1.CreateReferenceFromObject(hybridShapeExtremum5)

hybridShapeBlend3.SetClosingPoint 1, reference28

Set reference29 = part1.CreateReferenceFromObject(hybridShapeExtract6)

hybridShapeBlend3.SetCurve 2, reference29

hybridShapeBlend3.SetOrientation 2, 1

Set reference30 = part1.CreateReferenceFromObject(hybridShapeExtremum6)

hybridShapeBlend3.SetClosingPoint 2, reference30

hybridShapeBlend3.SmoothAngleThresholdActivity = False

hybridShapeBlend3.SmoothDeviationActivity = False

hybridShapeBlend3.RuledDevelopableSurface = False

hybridBody3.AppendHybridShape hybridShapeBlend3

part1.InWorkObject = hybridShapeBlend3

part1.Update 

Set hybridBody4 = hybridBodies1.Add()

part1.Update 

Set originElements1 = part1.OriginElements

Set hybridShapePlaneExplicit1 = originElements1.PlaneXY

Set reference31 = part1.CreateReferenceFromObject(hybridShapePlaneExplicit1)

Set hybridShapePlaneOffset1 = hybridShapeFactory1.AddNewPlaneOffset(reference31, -10.000000, False)

hybridBody4.AppendHybridShape hybridShapePlaneOffset1

part1.InWorkObject = hybridShapePlaneOffset1

part1.Update 

Set reference32 = part1.CreateReferenceFromObject(hybridShapePlaneExplicit1)

Set hybridShapePlaneOffset2 = hybridShapeFactory1.AddNewPlaneOffset(reference32, 340.000000, False)

hybridBody4.AppendHybridShape hybridShapePlaneOffset2

part1.InWorkObject = hybridShapePlaneOffset2

part1.Update 

Set reference33 = part1.CreateReferenceFromObject(hybridShapePlaneExplicit1)

Set hybridShapePlaneOffset3 = hybridShapeFactory1.AddNewPlaneOffset(reference33, 420.000000, False)

hybridBody4.AppendHybridShape hybridShapePlaneOffset3

part1.InWorkObject = hybridShapePlaneOffset3

part1.Update 

Set hybridShapePlaneExplicit2 = originElements1.PlaneYZ

Set reference34 = part1.CreateReferenceFromObject(hybridShapePlaneExplicit2)

Set hybridShapePlaneOffset4 = hybridShapeFactory1.AddNewPlaneOffset(reference34, 180.000000, False)

hybridBody4.AppendHybridShape hybridShapePlaneOffset4

part1.InWorkObject = hybridShapePlaneOffset4

part1.Update 

Set reference35 = part1.CreateReferenceFromObject(hybridShapePlaneExplicit2)

Set hybridShapePlaneOffset5 = hybridShapeFactory1.AddNewPlaneOffset(reference35, -40.000000, False)

hybridBody4.AppendHybridShape hybridShapePlaneOffset5

part1.InWorkObject = hybridShapePlaneOffset5

part1.Update 

Set sketches7 = hybridBody4.HybridSketches

Set hybridShapes1 = hybridBody4.HybridShapes

Set reference36 = hybridShapes1.Item("Plane.7")

Set sketch7 = sketches7.Add(reference36)

Dim arrayOfVariantOfDouble1(8)
arrayOfVariantOfDouble1(0) = 180.000000
arrayOfVariantOfDouble1(1) = 0.000000
arrayOfVariantOfDouble1(2) = 0.000000
arrayOfVariantOfDouble1(3) = 0.000000
arrayOfVariantOfDouble1(4) = 1.000000
arrayOfVariantOfDouble1(5) = 0.000000
arrayOfVariantOfDouble1(6) = 0.000000
arrayOfVariantOfDouble1(7) = 0.000000
arrayOfVariantOfDouble1(8) = 1.000000
sketch7.SetAbsoluteAxisData arrayOfVariantOfDouble1

part1.InWorkObject = sketch7

Set factory2D1 = sketch7.OpenEdition()

Set geometricElements1 = sketch7.GeometricElements

Set axis2D1 = geometricElements1.Item("AbsoluteAxis")

Set line2D1 = axis2D1.GetItem("HDirection")

line2D1.ReportName = 9

Set line2D2 = axis2D1.GetItem("VDirection")

line2D2.ReportName = 10

Set point2D1 = factory2D1.CreatePoint(0.000000, -10.000000)

point2D1.ReportName = 11

Set constraints1 = sketch7.Constraints

Set reference37 = part1.CreateReferenceFromObject(point2D1)

Set reference38 = part1.CreateReferenceFromObject(line2D2)

Set constraint1 = constraints1.AddBiEltCst(catCstTypeOn, reference37, reference38)

constraint1.Mode = catCstModeDrivingDimension

Set point2D2 = factory2D1.CreatePoint(4.000000, -10.000000)

point2D2.ReportName = 12

Set line2D3 = factory2D1.CreateLine(0.000000, -10.000000, 4.000000, -10.000000)

line2D3.ReportName = 13

line2D3.StartPoint = point2D1

line2D3.EndPoint = point2D2

Set point2D3 = factory2D1.CreatePoint(4.000000, 340.000000)

point2D3.ReportName = 14

Set line2D4 = factory2D1.CreateLine(4.000000, -10.000000, 4.000000, 340.000000)

line2D4.ReportName = 15

line2D4.StartPoint = point2D2

line2D4.EndPoint = point2D3

Set point2D4 = factory2D1.CreatePoint(0.000000, 340.000000)

point2D4.ReportName = 16

Set line2D5 = factory2D1.CreateLine(0.000000, 340.000000, 0.000000, -10.000000)

line2D5.ReportName = 17

line2D5.StartPoint = point2D4

line2D5.EndPoint = point2D1

Set reference39 = part1.CreateReferenceFromObject(line2D3)

Set reference40 = part1.CreateReferenceFromObject(line2D1)

Set constraint2 = constraints1.AddBiEltCst(catCstTypeHorizontality, reference39, reference40)

constraint2.Mode = catCstModeDrivingDimension

Set reference41 = part1.CreateReferenceFromObject(line2D4)

Set reference42 = part1.CreateReferenceFromObject(line2D2)

Set constraint3 = constraints1.AddBiEltCst(catCstTypeVerticality, reference41, reference42)

constraint3.Mode = catCstModeDrivingDimension

Set reference43 = part1.CreateReferenceFromObject(line2D5)

Set reference44 = part1.CreateReferenceFromObject(line2D2)

Set constraint4 = constraints1.AddBiEltCst(catCstTypeVerticality, reference43, reference44)

constraint4.Mode = catCstModeDrivingDimension

Set reference45 = part1.CreateReferenceFromObject(line2D3)

Set constraint5 = constraints1.AddMonoEltCst(catCstTypeLength, reference45)

constraint5.Mode = catCstModeDrivingDimension

Set length1 = constraint5.Dimension

length1.Value = 4.000000

Set reference46 = hybridShapes1.Item("Plane.4")

Set geometricElements2 = factory2D1.CreateIntersections(reference46)

Set geometry2D1 = geometricElements2.Item("Mark.1")

geometry2D1.Construction = True

Set reference47 = part1.CreateReferenceFromObject(line2D3)

Set reference48 = part1.CreateReferenceFromObject(geometry2D1)

Set constraint6 = constraints1.AddBiEltCst(catCstTypeOn, reference47, reference48)

constraint6.Mode = catCstModeDrivingDimension

Set point2D5 = factory2D1.CreatePoint(193.296127, 340.000000)

point2D5.ReportName = 18

Set point2D6 = factory2D1.CreatePoint(17.331947, 420.000000)

point2D6.ReportName = 19

Set circle2D1 = factory2D1.CreateCircle(193.296127, 340.000000, 193.296127, 2.714888, 3.141593)

circle2D1.CenterPoint = point2D5

circle2D1.ReportName = 20

circle2D1.StartPoint = point2D6

circle2D1.EndPoint = point2D4

Set point2D7 = factory2D1.CreatePoint(21.735573, 420.000000)

point2D7.ReportName = 21

Set circle2D2 = factory2D1.CreateCircle(193.296127, 340.000000, 189.296127, 2.705260, 3.141593)

circle2D2.CenterPoint = point2D5

circle2D2.ReportName = 22

circle2D2.StartPoint = point2D7

circle2D2.EndPoint = point2D3

Set reference49 = part1.CreateReferenceFromObject(circle2D2)

Set reference50 = part1.CreateReferenceFromObject(circle2D1)

Set constraint7 = constraints1.AddBiEltCst(catCstTypeDistance, reference49, reference50)

constraint7.Mode = catCstModeDrivingDimension

Set length2 = constraint7.Dimension

length2.Value = 4.000000

Set reference51 = part1.CreateReferenceFromObject(circle2D1)

Set reference52 = part1.CreateReferenceFromObject(line2D5)

Set constraint8 = constraints1.AddBiEltCst(catCstTypeTangency, reference51, reference52)

constraint8.Mode = catCstModeDrivingDimension

Set reference53 = hybridShapes1.Item("Plane.5")

Set geometricElements3 = factory2D1.CreateIntersections(reference53)

Set geometry2D2 = geometricElements3.Item("Mark.1")

geometry2D2.Construction = True

Set reference54 = part1.CreateReferenceFromObject(point2D5)

Set reference55 = part1.CreateReferenceFromObject(geometry2D2)

Set constraint9 = constraints1.AddBiEltCst(catCstTypeOn, reference54, reference55)

constraint9.Mode = catCstModeDrivingDimension

Set line2D6 = factory2D1.CreateLine(17.331947, 420.000000, 21.735573, 420.000000)

line2D6.ReportName = 23

line2D6.StartPoint = point2D6

line2D6.EndPoint = point2D7

Set reference56 = part1.CreateReferenceFromObject(line2D6)

Set reference57 = part1.CreateReferenceFromObject(line2D1)

Set constraint10 = constraints1.AddBiEltCst(catCstTypeHorizontality, reference56, reference57)

constraint10.Mode = catCstModeDrivingDimension

Set reference58 = hybridShapes1.Item("Plane.6")

Set geometricElements4 = factory2D1.CreateIntersections(reference58)

Set geometry2D3 = geometricElements4.Item("Mark.1")

geometry2D3.Construction = True

Set reference59 = part1.CreateReferenceFromObject(line2D6)

Set reference60 = part1.CreateReferenceFromObject(geometry2D3)

Set constraint11 = constraints1.AddBiEltCst(catCstTypeOn, reference59, reference60)

constraint11.Mode = catCstModeDrivingDimension

Set point2D8 = factory2D1.CreatePoint(-28.091932, 313.144571)

point2D8.ReportName = 24

Set point2D9 = factory2D1.CreatePoint(51.691066, 484.239762)

point2D9.ReportName = 25

Set line2D7 = factory2D1.CreateLine(-28.091932, 313.144571, 51.691066, 484.239762)

line2D7.ReportName = 26

line2D7.StartPoint = point2D8

line2D7.EndPoint = point2D9

Set reference61 = part1.CreateReferenceFromObject(line2D7)

Set reference62 = part1.CreateReferenceFromObject(point2D7)

Set constraint12 = constraints1.AddBiEltCst(catCstTypeOn, reference61, reference62)

constraint12.Mode = catCstModeDrivingDimension

Set reference63 = part1.CreateReferenceFromObject(line2D7)

Set reference64 = part1.CreateReferenceFromObject(circle2D2)

Set constraint13 = constraints1.AddBiEltCst(catCstTypeTangency, reference63, reference64)

constraint13.Mode = catCstModeDrivingDimension

Set reference65 = part1.CreateReferenceFromObject(line2D7)

Set reference66 = part1.CreateReferenceFromObject(line2D5)

Set constraint14 = constraints1.AddBiEltCst(catCstTypeAngle, reference65, reference66)

constraint14.Mode = catCstModeDrivingDimension

constraint14.AngleSector = catCstAngleSector1

Set angle1 = constraint14.Dimension

angle1.Value = 25.000000

sketch7.CenterLine = line2D7

sketch7.CloseEdition 

part1.InWorkObject = hybridBody4

part1.Update 

length2.Value = 4.000000

length2.Value = 4.000000

Set hybridShapeFill1 = hybridShapeFactory1.AddNewFill()

Set reference67 = part1.CreateReferenceFromObject(sketch7)

hybridShapeFill1.AddBound reference67

hybridShapeFill1.Continuity = 0

hybridBody4.AppendHybridShape hybridShapeFill1

part1.InWorkObject = hybridShapeFill1

part1.Update 

Set reference68 = part1.CreateReferenceFromObject(hybridShapePlaneExplicit2)

Set hybridShapeDirection13 = hybridShapeFactory1.AddNewDirection(reference68)

Set reference69 = part1.CreateReferenceFromObject(hybridShapeFill1)

Set hybridShapeExtrude7 = hybridShapeFactory1.AddNewExtrude(reference69, 75.000000, 0.000000, hybridShapeDirection13)

hybridShapeExtrude7.FirstLimitType = 2

Set reference70 = part1.CreateReferenceFromObject(hybridShapePlaneOffset5)

hybridShapeExtrude7.FirstUptoElement = reference70

hybridShapeExtrude7.SymmetricalExtension = 0

hybridBody4.AppendHybridShape hybridShapeExtrude7

part1.InWorkObject = hybridShapeExtrude7

part1.Update 

Set hybridBody5 = hybridBodies1.Add()

part1.Update 

Set sketches8 = hybridBody5.HybridSketches

Set sketch8 = sketches8.Add(reference53)

Dim arrayOfVariantOfDouble2(8)
arrayOfVariantOfDouble2(0) = 0.000000
arrayOfVariantOfDouble2(1) = 0.000000
arrayOfVariantOfDouble2(2) = 340.000000
arrayOfVariantOfDouble2(3) = 1.000000
arrayOfVariantOfDouble2(4) = 0.000000
arrayOfVariantOfDouble2(5) = 0.000000
arrayOfVariantOfDouble2(6) = 0.000000
arrayOfVariantOfDouble2(7) = 1.000000
arrayOfVariantOfDouble2(8) = 0.000000
sketch8.SetAbsoluteAxisData arrayOfVariantOfDouble2

part1.InWorkObject = sketch8

Set factory2D2 = sketch8.OpenEdition()

Set geometricElements5 = sketch8.GeometricElements

Set axis2D2 = geometricElements5.Item("AbsoluteAxis")

Set line2D8 = axis2D2.GetItem("HDirection")

line2D8.ReportName = 4

Set line2D9 = axis2D2.GetItem("VDirection")

line2D9.ReportName = 5

Set point2D10 = factory2D2.CreatePoint(-40.000000, 12.178203)

point2D10.ReportName = 6

Set point2D11 = factory2D2.CreatePoint(-36.000000, 5.250000)

point2D11.ReportName = 7

Set point2D12 = factory2D2.CreatePoint(-40.000000, 20.178203)

point2D12.ReportName = 8

Set circle2D3 = factory2D2.CreateCircle(-40.000000, 12.178203, 8.000000, 5.235988, 7.853982)

circle2D3.CenterPoint = point2D10

circle2D3.ReportName = 9

circle2D3.StartPoint = point2D11

circle2D3.EndPoint = point2D12

Set point2D13 = factory2D2.CreatePoint(-40.000000, 6.178203)

point2D13.ReportName = 10

Set point2D14 = factory2D2.CreatePoint(-40.000000, 18.178203)

point2D14.ReportName = 11

Set circle2D4 = factory2D2.CreateCircle(-40.000000, 12.178203, 6.000000, 4.712389, 7.853982)

circle2D4.CenterPoint = point2D10

circle2D4.ReportName = 12

circle2D4.StartPoint = point2D13

circle2D4.EndPoint = point2D14

Set constraints2 = sketch8.Constraints

Set reference71 = part1.CreateReferenceFromObject(circle2D3)

Set reference72 = part1.CreateReferenceFromObject(circle2D4)

Set constraint15 = constraints2.AddBiEltCst(catCstTypeDistance, reference71, reference72)

constraint15.Mode = catCstModeDrivingDimension

Set length3 = constraint15.Dimension

length3.Value = 2.000000

Set point2D15 = factory2D2.CreatePoint(-40.000000, 4.000000)

point2D15.ReportName = 13

Set point2D16 = factory2D2.CreatePoint(-36.000000, 4.000000)

point2D16.ReportName = 14

Set line2D10 = factory2D2.CreateLine(-40.000000, 4.000000, -36.000000, 4.000000)

line2D10.ReportName = 15

line2D10.StartPoint = point2D15

line2D10.EndPoint = point2D16

Set reference73 = part1.CreateReferenceFromObject(line2D10)

Set reference74 = part1.CreateReferenceFromObject(line2D8)

Set constraint16 = constraints2.AddBiEltCst(catCstTypeHorizontality, reference73, reference74)

constraint16.Mode = catCstModeDrivingDimension

Set reference75 = part1.CreateReferenceFromObject(line2D10)

Set constraint17 = constraints2.AddMonoEltCst(catCstTypeLength, reference75)

constraint17.Mode = catCstModeDrivingDimension

Set length4 = constraint17.Dimension

length4.Value = 4.000000

Set reference76 = part1.CreateReferenceFromBRepName("FVertex:(Vertex:(Neighbours:(Face:(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));None:();Cf11:());Face:(Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));None:();Cf11:());Face:(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))));None:();Cf11:()));Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", hybridShapeExtrude7)

Set geometricElements6 = factory2D2.CreateProjections(reference76)

Set geometry2D4 = geometricElements6.Item("Mark.1")

geometry2D4.Construction = True

Set reference77 = part1.CreateReferenceFromObject(point2D15)

Set reference78 = part1.CreateReferenceFromObject(geometry2D4)

Set constraint18 = constraints2.AddBiEltCst(catCstTypeOn, reference77, reference78)

constraint18.Mode = catCstModeDrivingDimension

Set reference79 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;22)))));None:();Cf11:());Face:(Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", hybridShapeExtrude7)

Set geometricElements7 = factory2D2.CreateProjections(reference79)

Set geometry2D5 = geometricElements7.Item("Mark.1")

geometry2D5.Construction = True

Set reference80 = part1.CreateReferenceFromObject(point2D10)

Set reference81 = part1.CreateReferenceFromObject(geometry2D5)

Set constraint19 = constraints2.AddBiEltCst(catCstTypeOn, reference80, reference81)

constraint19.Mode = catCstModeDrivingDimension

Set reference82 = part1.CreateReferenceFromObject(circle2D3)

Set constraint20 = constraints2.AddMonoEltCst(catCstTypeRadius, reference82)

constraint20.Mode = catCstModeDrivingDimension

Set length5 = constraint20.Dimension

length5.Value = 8.000000

Set point2D17 = factory2D2.CreatePoint(-40.000000, 4.178203)

point2D17.ReportName = 16

Set line2D11 = factory2D2.CreateLine(-40.000000, 6.178203, -40.000000, 4.178203)

line2D11.ReportName = 17

line2D11.StartPoint = point2D13

line2D11.EndPoint = point2D17

Set reference83 = part1.CreateReferenceFromObject(line2D11)

Set reference84 = part1.CreateReferenceFromObject(line2D9)

Set constraint21 = constraints2.AddBiEltCst(catCstTypeVerticality, reference83, reference84)

constraint21.Mode = catCstModeDrivingDimension

Set line2D12 = factory2D2.CreateLine(-40.000000, 18.178203, -40.000000, 20.178203)

line2D12.ReportName = 18

line2D12.StartPoint = point2D14

line2D12.EndPoint = point2D12

Set reference85 = part1.CreateReferenceFromObject(point2D14)

Set reference86 = part1.CreateReferenceFromObject(line2D11)

Set constraint22 = constraints2.AddBiEltCst(catCstTypeOn, reference85, reference86)

constraint22.Mode = catCstModeDrivingDimension

Set reference87 = part1.CreateReferenceFromObject(line2D12)

Set reference88 = part1.CreateReferenceFromObject(line2D9)

Set constraint23 = constraints2.AddBiEltCst(catCstTypeVerticality, reference87, reference88)

constraint23.Mode = catCstModeDrivingDimension

Set reference89 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;22)))));None:();Cf11:());Face:(Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", hybridShapeExtrude7)

Set geometricElements8 = factory2D2.CreateProjections(reference89)

Set geometry2D6 = geometricElements8.Item("Mark.1")

geometry2D6.Construction = True

Set reference90 = part1.CreateReferenceFromObject(line2D11)

Set reference91 = part1.CreateReferenceFromObject(geometry2D6)

Set constraint24 = constraints2.AddBiEltCst(catCstTypeOn, reference90, reference91)

constraint24.Mode = catCstModeDrivingDimension

Set line2D13 = factory2D2.CreateLine(-36.000000, 4.000000, -36.000000, 5.250000)

line2D13.ReportName = 19

line2D13.StartPoint = point2D16

line2D13.EndPoint = point2D11

Set reference92 = part1.CreateReferenceFromObject(line2D13)

Set reference93 = part1.CreateReferenceFromObject(line2D9)

Set constraint25 = constraints2.AddBiEltCst(catCstTypeVerticality, reference92, reference93)

constraint25.Mode = catCstModeDrivingDimension

Set reference94 = part1.CreateReferenceFromObject(line2D13)

Set constraint26 = constraints2.AddMonoEltCst(catCstTypeLength, reference94)

constraint26.Mode = catCstModeDrivingDimension

Set length6 = constraint26.Dimension

length6.Value = 1.250000

Set line2D14 = factory2D2.CreateLine(-40.000000, 4.178203, -40.000000, 4.000000)

line2D14.ReportName = 20

line2D14.StartPoint = point2D17

line2D14.EndPoint = point2D15

Set reference95 = part1.CreateReferenceFromObject(line2D14)

Set reference96 = part1.CreateReferenceFromObject(line2D9)

Set constraint27 = constraints2.AddBiEltCst(catCstTypeVerticality, reference95, reference96)

constraint27.Mode = catCstModeDrivingDimension

sketch8.CloseEdition 

part1.InWorkObject = hybridBody5

part1.Update 

length3.Value = 2.000000

length3.Value = 2.000000

Set reference97 = part1.CreateReferenceFromObject(sketch8)

Set reference98 = part1.CreateReferenceFromBRepName("REdge:(Edge:(Face:(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;22)))));None:();Cf11:());Face:(Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)", hybridShapeExtrude7)

Set hybridShapeSweepExplicit1 = hybridShapeFactory1.AddNewSweepExplicit(reference97, reference98)

hybridShapeSweepExplicit1.SubType = 1

Set reference99 = part1.CreateReferenceFromObject(hybridShapeExtrude7)

hybridShapeSweepExplicit1.Reference = reference99

hybridShapeSweepExplicit1.SetAngleRef 1, 0.000000

hybridShapeSweepExplicit1.SolutionNo = 0

hybridShapeSweepExplicit1.SmoothActivity = False

hybridShapeSweepExplicit1.GuideDeviationActivity = False

hybridShapeSweepExplicit1.SetbackValue = 0.020000

hybridShapeSweepExplicit1.FillTwistedAreas = 1

hybridShapeSweepExplicit1.C0VerticesMode = True

hybridBody5.AppendHybridShape hybridShapeSweepExplicit1

part1.InWorkObject = hybridShapeSweepExplicit1

part1.Update 

part1.Update 

Set reference100 = part1.CreateReferenceFromObject(sketch8)

Set reference101 = part1.CreateReferenceFromBRepName("REdge:(Edge:(Face:(Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));None:();Cf11:());Face:(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)", hybridShapeExtrude7)

Set hybridShapeSweepExplicit2 = hybridShapeFactory1.AddNewSweepExplicit(reference100, reference101)

hybridShapeSweepExplicit2.SubType = 1

Set reference102 = part1.CreateReferenceFromObject(hybridShapeExtrude7)

hybridShapeSweepExplicit2.Reference = reference102

hybridShapeSweepExplicit2.SetAngleRef 1, 0.000000

hybridShapeSweepExplicit2.SolutionNo = 0

hybridShapeSweepExplicit2.SmoothActivity = False

hybridShapeSweepExplicit2.GuideDeviationActivity = False

hybridShapeSweepExplicit2.SetbackValue = 0.020000

hybridShapeSweepExplicit2.FillTwistedAreas = 1

hybridShapeSweepExplicit2.C0VerticesMode = True

hybridBody5.AppendHybridShape hybridShapeSweepExplicit2

part1.InWorkObject = hybridShapeSweepExplicit2

part1.Update 

part1.Update 

Set hybridBody6 = hybridBodies1.Add()

part1.Update 

Set sketches9 = hybridBody6.HybridSketches

Set reference103 = part1.CreateReferenceFromName("Selection_RSur:(Face:(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));None:();Cf11:());GSMExtrude.7;Z0;G4074)")

Set sketch9 = sketches9.Add(reference103)

Dim arrayOfVariantOfDouble3(8)
arrayOfVariantOfDouble3(0) = 0.000000
arrayOfVariantOfDouble3(1) = 4.000000
arrayOfVariantOfDouble3(2) = 0.000000
arrayOfVariantOfDouble3(3) = 1.000000
arrayOfVariantOfDouble3(4) = 0.000000
arrayOfVariantOfDouble3(5) = 0.000000
arrayOfVariantOfDouble3(6) = -0.000000
arrayOfVariantOfDouble3(7) = 0.000000
arrayOfVariantOfDouble3(8) = 1.000000
sketch9.SetAbsoluteAxisData arrayOfVariantOfDouble3

part1.InWorkObject = sketch9

Set factory2D3 = sketch9.OpenEdition()

Set geometricElements9 = sketch9.GeometricElements

Set axis2D3 = geometricElements9.Item("AbsoluteAxis")

Set line2D15 = axis2D3.GetItem("HDirection")

line2D15.ReportName = 7

Set line2D16 = axis2D3.GetItem("VDirection")

line2D16.ReportName = 8

Set point2D18 = factory2D3.CreatePoint(33.000000, 10.000000)

point2D18.ReportName = 9

Set point2D19 = factory2D3.CreatePoint(30.000000, 10.000000)

point2D19.ReportName = 10

Set line2D17 = factory2D3.CreateLine(33.000000, 10.000000, 30.000000, 10.000000)

line2D17.ReportName = 11

line2D17.EndPoint = point2D18

line2D17.StartPoint = point2D19

Set point2D20 = factory2D3.CreatePoint(30.000000, 100.000000)

point2D20.ReportName = 12

Set line2D18 = factory2D3.CreateLine(30.000000, 10.000000, 30.000000, 100.000000)

line2D18.ReportName = 13

line2D18.StartPoint = point2D19

line2D18.EndPoint = point2D20

Set point2D21 = factory2D3.CreatePoint(33.000000, 100.000000)

point2D21.ReportName = 14

Set line2D19 = factory2D3.CreateLine(33.000000, 100.000000, 33.000000, 10.000000)

line2D19.ReportName = 15

line2D19.StartPoint = point2D21

line2D19.EndPoint = point2D18

Set constraints3 = sketch9.Constraints

Set reference104 = part1.CreateReferenceFromObject(line2D17)

Set reference105 = part1.CreateReferenceFromObject(line2D15)

Set constraint28 = constraints3.AddBiEltCst(catCstTypeHorizontality, reference104, reference105)

constraint28.Mode = catCstModeDrivingDimension

Set reference106 = part1.CreateReferenceFromObject(line2D18)

Set reference107 = part1.CreateReferenceFromObject(line2D16)

Set constraint29 = constraints3.AddBiEltCst(catCstTypeVerticality, reference106, reference107)

constraint29.Mode = catCstModeDrivingDimension

Set reference108 = part1.CreateReferenceFromObject(line2D19)

Set reference109 = part1.CreateReferenceFromObject(line2D16)

Set constraint30 = constraints3.AddBiEltCst(catCstTypeVerticality, reference108, reference109)

constraint30.Mode = catCstModeDrivingDimension

Set geometricElements10 = factory2D3.CreateIntersections(reference46)

Set geometry2D7 = geometricElements10.Item("Mark.1")

geometry2D7.Construction = True

Set reference110 = part1.CreateReferenceFromObject(line2D17)

Set reference111 = part1.CreateReferenceFromObject(geometry2D7)

Set constraint31 = constraints3.AddBiEltCst(catCstTypeDistance, reference110, reference111)

constraint31.Mode = catCstModeDrivingDimension

Set length7 = constraint31.Dimension

length7.Value = 20.000000

Set reference112 = part1.CreateReferenceFromObject(line2D17)

Set constraint32 = constraints3.AddMonoEltCst(catCstTypeLength, reference112)

constraint32.Mode = catCstModeDrivingDimension

Set length8 = constraint32.Dimension

length8.Value = 3.000000

Set reference113 = hybridShapes1.Item("Plane.8")

Set geometricElements11 = factory2D3.CreateIntersections(reference113)

Set geometry2D8 = geometricElements11.Item("Mark.1")

geometry2D8.Construction = True

Set reference114 = part1.CreateReferenceFromObject(line2D18)

Set reference115 = part1.CreateReferenceFromObject(geometry2D8)

Set constraint33 = constraints3.AddBiEltCst(catCstTypeDistance, reference114, reference115)

constraint33.Mode = catCstModeDrivingDimension

Set length9 = constraint33.Dimension

length9.Value = 70.000000

Set point2D22 = factory2D3.CreatePoint(280.000000, 100.000000)

point2D22.ReportName = 16

Set point2D23 = factory2D3.CreatePoint(150.000000, 313.541565)

point2D23.ReportName = 17

Set circle2D5 = factory2D3.CreateCircle(280.000000, 100.000000, 250.000000, 2.117647, 3.141593)

circle2D5.CenterPoint = point2D22

circle2D5.ReportName = 18

circle2D5.StartPoint = point2D23

circle2D5.EndPoint = point2D20

Set point2D24 = factory2D3.CreatePoint(150.000000, 310.021427)

point2D24.ReportName = 19

Set circle2D6 = factory2D3.CreateCircle(280.000000, 100.000000, 247.000000, 2.125058, 3.141593)

circle2D6.CenterPoint = point2D22

circle2D6.ReportName = 20

circle2D6.StartPoint = point2D24

circle2D6.EndPoint = point2D21

Set reference116 = part1.CreateReferenceFromObject(circle2D6)

Set reference117 = part1.CreateReferenceFromObject(circle2D5)

Set constraint34 = constraints3.AddBiEltCst(catCstTypeDistance, reference116, reference117)

constraint34.Mode = catCstModeDrivingDimension

Set length10 = constraint34.Dimension

length10.Value = 3.000000

Set reference118 = part1.CreateReferenceFromObject(circle2D5)

Set reference119 = part1.CreateReferenceFromObject(line2D18)

Set constraint35 = constraints3.AddBiEltCst(catCstTypeTangency, reference118, reference119)

constraint35.Mode = catCstModeDrivingDimension

Set geometricElements12 = factory2D3.CreateIntersections(reference46)

Set geometry2D9 = geometricElements12.Item("Mark.1")

geometry2D9.Construction = True

Set reference120 = part1.CreateReferenceFromObject(point2D22)

Set reference121 = part1.CreateReferenceFromObject(geometry2D9)

Set constraint36 = constraints3.AddBiEltCst(catCstTypeDistance, reference120, reference121)

constraint36.Mode = catCstModeDrivingDimension

Set length11 = constraint36.Dimension

length11.Value = 110.000000

Set reference122 = part1.CreateReferenceFromObject(circle2D5)

Set constraint37 = constraints3.AddMonoEltCst(catCstTypeRadius, reference122)

constraint37.Mode = catCstModeDrivingDimension

Set length12 = constraint37.Dimension

length12.Value = 250.000000

Set line2D20 = factory2D3.CreateLine(150.000000, 310.021427, 150.000000, 313.541565)

line2D20.ReportName = 21

line2D20.StartPoint = point2D24

line2D20.EndPoint = point2D23

Set reference123 = part1.CreateReferenceFromObject(line2D20)

Set reference124 = part1.CreateReferenceFromObject(line2D16)

Set constraint38 = constraints3.AddBiEltCst(catCstTypeVerticality, reference123, reference124)

constraint38.Mode = catCstModeDrivingDimension

Set geometricElements13 = factory2D3.CreateIntersections(reference113)

Set geometry2D10 = geometricElements13.Item("Mark.1")

geometry2D10.Construction = True

Set reference125 = part1.CreateReferenceFromObject(line2D20)

Set reference126 = part1.CreateReferenceFromObject(geometry2D10)

Set constraint39 = constraints3.AddBiEltCst(catCstTypeDistance, reference125, reference126)

constraint39.Mode = catCstModeDrivingDimension

Set length13 = constraint39.Dimension

length13.Value = 190.000000

sketch9.CloseEdition 

part1.InWorkObject = hybridBody6

part1.Update 

length7.Value = 20.000000

length9.Value = 70.000000

length10.Value = 3.000000

length11.Value = 110.000000

length13.Value = 190.000000

length7.Value = 20.000000

length9.Value = 70.000000

length10.Value = 3.000000

length11.Value = 110.000000

length13.Value = 190.000000

Set hybridShapeFill2 = hybridShapeFactory1.AddNewFill()

Set reference127 = part1.CreateReferenceFromObject(sketch9)

hybridShapeFill2.AddBound reference127

hybridShapeFill2.Continuity = 0

hybridBody6.AppendHybridShape hybridShapeFill2

part1.InWorkObject = hybridShapeFill2

part1.Update 

Set hybridShapePlaneExplicit3 = originElements1.PlaneZX

Set reference128 = part1.CreateReferenceFromObject(hybridShapePlaneExplicit3)

Set hybridShapeDirection14 = hybridShapeFactory1.AddNewDirection(reference128)

Set reference129 = part1.CreateReferenceFromObject(sketch9)

Set hybridShapeExtrude8 = hybridShapeFactory1.AddNewExtrude(reference129, 25.000000, 0.000000, hybridShapeDirection14)

hybridShapeExtrude8.SymmetricalExtension = 0

hybridBody6.AppendHybridShape hybridShapeExtrude8

part1.InWorkObject = hybridShapeExtrude8

part1.Update 

Set hybridBody7 = hybridBodies1.Add()

part1.Update 

Set sketches10 = hybridBody7.HybridSketches

Set hybridBody8 = hybridBodies1.Item("Airfoil gaps")

Set hybridShapes2 = hybridBody8.HybridShapes

Set reference130 = hybridShapes2.Item("Plane.3")

Set sketch10 = sketches10.Add(reference130)

Dim arrayOfVariantOfDouble4(8)
arrayOfVariantOfDouble4(0) = 0.000000
arrayOfVariantOfDouble4(1) = -400.000000
arrayOfVariantOfDouble4(2) = 0.000000
arrayOfVariantOfDouble4(3) = -1.000000
arrayOfVariantOfDouble4(4) = 0.000000
arrayOfVariantOfDouble4(5) = 0.000000
arrayOfVariantOfDouble4(6) = 0.000000
arrayOfVariantOfDouble4(7) = -0.000000
arrayOfVariantOfDouble4(8) = 1.000000
sketch10.SetAbsoluteAxisData arrayOfVariantOfDouble4

part1.InWorkObject = sketch10

Set factory2D4 = sketch10.OpenEdition()

Set geometricElements14 = sketch10.GeometricElements

Set axis2D4 = geometricElements14.Item("AbsoluteAxis")

Set line2D21 = axis2D4.GetItem("HDirection")

line2D21.ReportName = 8

Set line2D22 = axis2D4.GetItem("VDirection")

line2D22.ReportName = 9

Set point2D25 = factory2D4.CreatePoint(-61.537664, 346.174022)

point2D25.ReportName = 10

Set point2D26 = factory2D4.CreatePoint(-112.358001, 346.174022)

point2D26.ReportName = 11

Set line2D23 = factory2D4.CreateLine(-61.537664, 346.174022, -112.358001, 346.174022)

line2D23.ReportName = 3

line2D23.EndPoint = point2D25

line2D23.StartPoint = point2D26

Set point2D27 = factory2D4.CreatePoint(-112.358001, 272.359514)

point2D27.ReportName = 12

Set line2D24 = factory2D4.CreateLine(-112.358001, 346.174022, -112.358001, 272.359514)

line2D24.ReportName = 4

line2D24.EndPoint = point2D26

line2D24.StartPoint = point2D27

Set point2D28 = factory2D4.CreatePoint(-35.093238, 156.834289)

point2D28.ReportName = 13

Set point2D29 = factory2D4.CreatePoint(13.462336, 156.834289)

point2D29.ReportName = 14

Set line2D25 = factory2D4.CreateLine(-35.093238, 156.834289, 13.462336, 156.834289)

line2D25.ReportName = 5

line2D25.EndPoint = point2D28

line2D25.StartPoint = point2D29

Set point2D30 = factory2D4.CreatePoint(13.462336, 271.174022)

point2D30.ReportName = 15

Set line2D26 = factory2D4.CreateLine(13.462336, 156.834289, 13.462336, 271.174022)

line2D26.ReportName = 6

line2D26.EndPoint = point2D29

line2D26.StartPoint = point2D30

Set constraints4 = sketch10.Constraints

Set reference131 = part1.CreateReferenceFromObject(line2D23)

Set reference132 = part1.CreateReferenceFromObject(line2D21)

Set constraint40 = constraints4.AddBiEltCst(catCstTypeHorizontality, reference131, reference132)

constraint40.Mode = catCstModeDrivingDimension

Set reference133 = part1.CreateReferenceFromObject(line2D25)

Set reference134 = part1.CreateReferenceFromObject(line2D21)

Set constraint41 = constraints4.AddBiEltCst(catCstTypeHorizontality, reference133, reference134)

constraint41.Mode = catCstModeDrivingDimension

Set reference135 = part1.CreateReferenceFromObject(line2D24)

Set reference136 = part1.CreateReferenceFromObject(line2D22)

Set constraint42 = constraints4.AddBiEltCst(catCstTypeVerticality, reference135, reference136)

constraint42.Mode = catCstModeDrivingDimension

Set reference137 = part1.CreateReferenceFromObject(line2D26)

Set reference138 = part1.CreateReferenceFromObject(line2D22)

Set constraint43 = constraints4.AddBiEltCst(catCstTypeVerticality, reference137, reference138)

constraint43.Mode = catCstModeDrivingDimension

Set reference139 = part1.CreateReferenceFromBRepName("WireREdge:(Wire:(Brp:(Sketch.6;1);None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MonoFond;MFBRepVersion_CXR15)", sketch6)

Set geometricElements15 = factory2D4.CreateProjections(reference139)

Set geometry2D11 = geometricElements15.Item("Mark.1")

geometry2D11.Construction = True

Set reference140 = part1.CreateReferenceFromObject(line2D24)

Set reference141 = part1.CreateReferenceFromObject(geometry2D11)

Set constraint44 = constraints4.AddBiEltCst(catCstTypeDistance, reference140, reference141)

constraint44.Mode = catCstModeDrivingDimension

Set length14 = constraint44.Dimension

length14.Value = 20.000000

Set reference142 = part1.CreateReferenceFromBRepName("WireREdge:(Wire:(Brp:(Sketch.6;1);None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MonoFond;MFBRepVersion_CXR15)", sketch6)

Set geometricElements16 = factory2D4.CreateProjections(reference142)

Set geometry2D12 = geometricElements16.Item("Mark.1")

geometry2D12.Construction = True

Set reference143 = part1.CreateReferenceFromObject(line2D23)

Set reference144 = part1.CreateReferenceFromObject(geometry2D12)

Set constraint45 = constraints4.AddBiEltCst(catCstTypeDistance, reference143, reference144)

constraint45.Mode = catCstModeDrivingDimension

Set length15 = constraint45.Dimension

length15.Value = 20.000000

Set reference145 = part1.CreateReferenceFromBRepName("WireREdge:(Wire:(Brp:(Sketch.5;1);None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MonoFond;MFBRepVersion_CXR15)", sketch4)

Set geometricElements17 = factory2D4.CreateProjections(reference145)

Set geometry2D13 = geometricElements17.Item("Mark.1")

geometry2D13.Construction = True

Set reference146 = part1.CreateReferenceFromObject(line2D25)

Set reference147 = part1.CreateReferenceFromObject(geometry2D13)

Set constraint46 = constraints4.AddBiEltCst(catCstTypeDistance, reference146, reference147)

constraint46.Mode = catCstModeDrivingDimension

Set length16 = constraint46.Dimension

length16.Value = 70.000000

Set reference148 = part1.CreateReferenceFromBRepName("WireREdge:(Wire:(Brp:(Sketch.5;1);None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MonoFond;MFBRepVersion_CXR15)", sketch4)

Set geometricElements18 = factory2D4.CreateProjections(reference148)

Set geometry2D14 = geometricElements18.Item("Mark.1")

geometry2D14.Construction = True

Set reference149 = part1.CreateReferenceFromObject(line2D26)

Set reference150 = part1.CreateReferenceFromObject(geometry2D14)

Set constraint47 = constraints4.AddBiEltCst(catCstTypeDistance, reference149, reference150)

constraint47.Mode = catCstModeDrivingDimension

Set length17 = constraint47.Dimension

length17.Value = 50.000000

Set point2D31 = factory2D4.CreatePoint(-56.743873, 169.334289)

point2D31.ReportName = 16

Set point2D32 = factory2D4.CreatePoint(-109.008636, 259.859514)

point2D32.ReportName = 17

Set line2D27 = factory2D4.CreateLine(-56.743873, 169.334289, -109.008636, 259.859514)

line2D27.ReportName = 7

line2D27.StartPoint = point2D31

line2D27.EndPoint = point2D32

Set point2D33 = factory2D4.CreatePoint(-49.526995, 156.834289)

point2D33.ReportName = 18

Set reference151 = part1.CreateReferenceFromObject(line2D27)

Set reference152 = part1.CreateReferenceFromObject(line2D25)

Set constraint48 = constraints4.AddBiEltCst(catCstTypeAngle, reference151, reference152)

constraint48.Mode = catCstModeDrivingDimension

constraint48.AngleSector = catCstAngleSector0

Set angle2 = constraint48.Dimension

angle2.Value = 60.000000

Set reference153 = part1.CreateReferenceFromBRepName("BorderREdge:(Wire:(Brp:(GSMExtrude.2;2:(Brp:(Sketch.4;1)));None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithSelectingFeatureSupport;MonoFond;MFBRepVersion_CXR15)", hybridShapeExtract2)

Set geometricElements19 = factory2D4.CreateProjections(reference153)

Set geometry2D15 = geometricElements19.Item("Mark.1")

geometry2D15.Construction = True

Set reference154 = part1.CreateReferenceFromObject(point2D33)

Set reference155 = part1.CreateReferenceFromObject(geometry2D15)

Set constraint49 = constraints4.AddBiEltCst(catCstTypeDistance, reference154, reference155)

constraint49.Mode = catCstModeDrivingDimension

Set length18 = constraint49.Dimension

length18.Value = 45.000000

Set point2D34 = factory2D4.CreatePoint(-35.093238, 181.834289)

point2D34.ReportName = 19

Set circle2D7 = factory2D4.CreateCircle(-35.093238, 181.834289, 25.000000, 3.665191, 4.712389)

circle2D7.CenterPoint = point2D34

circle2D7.ReportName = 20

circle2D7.EndPoint = point2D28

circle2D7.StartPoint = point2D31

Set reference156 = part1.CreateReferenceFromObject(line2D25)

Set reference157 = part1.CreateReferenceFromObject(point2D33)

Set constraint50 = constraints4.AddBiEltCst(catCstTypeOn, reference156, reference157)

constraint50.Mode = catCstModeDrivingDimension

Set reference158 = part1.CreateReferenceFromObject(line2D27)

Set reference159 = part1.CreateReferenceFromObject(point2D33)

Set constraint51 = constraints4.AddBiEltCst(catCstTypeOn, reference158, reference159)

constraint51.Mode = catCstModeDrivingDimension

Set reference160 = part1.CreateReferenceFromObject(circle2D7)

Set reference161 = part1.CreateReferenceFromObject(line2D25)

Set constraint52 = constraints4.AddBiEltCst(catCstTypeTangency, reference160, reference161)

constraint52.Mode = catCstModeDrivingDimension

Set reference162 = part1.CreateReferenceFromObject(circle2D7)

Set reference163 = part1.CreateReferenceFromObject(line2D27)

Set constraint53 = constraints4.AddBiEltCst(catCstTypeTangency, reference162, reference163)

constraint53.Mode = catCstModeDrivingDimension

Set reference164 = part1.CreateReferenceFromObject(circle2D7)

Set constraint54 = constraints4.AddMonoEltCst(catCstTypeRadius, reference164)

constraint54.Mode = catCstModeDrivingDimension

Set length19 = constraint54.Dimension

length19.Value = 25.000000

Set point2D35 = factory2D4.CreatePoint(-87.358001, 272.359514)

point2D35.ReportName = 21

Set circle2D8 = factory2D4.CreateCircle(-87.358001, 272.359514, 25.000000, 3.141593, 3.665191)

circle2D8.CenterPoint = point2D35

circle2D8.ReportName = 22

circle2D8.EndPoint = point2D32

circle2D8.StartPoint = point2D27

Set reference165 = part1.CreateReferenceFromObject(circle2D8)

Set reference166 = part1.CreateReferenceFromObject(line2D27)

Set constraint55 = constraints4.AddBiEltCst(catCstTypeTangency, reference165, reference166)

constraint55.Mode = catCstModeDrivingDimension

Set reference167 = part1.CreateReferenceFromObject(circle2D8)

Set reference168 = part1.CreateReferenceFromObject(line2D24)

Set constraint56 = constraints4.AddBiEltCst(catCstTypeTangency, reference167, reference168)

constraint56.Mode = catCstModeDrivingDimension

Set reference169 = part1.CreateReferenceFromObject(circle2D8)

Set constraint57 = constraints4.AddMonoEltCst(catCstTypeRadius, reference169)

constraint57.Mode = catCstModeDrivingDimension

Set length20 = constraint57.Dimension

length20.Value = 25.000000

Set point2D36 = factory2D4.CreatePoint(-61.537664, 271.174022)

point2D36.ReportName = 23

Set circle2D9 = factory2D4.CreateCircle(-61.537664, 271.174022, 75.000000, 6.283185, 7.853982)

circle2D9.CenterPoint = point2D36

circle2D9.ReportName = 24

circle2D9.EndPoint = point2D25

circle2D9.StartPoint = point2D30

Set reference170 = part1.CreateReferenceFromObject(circle2D9)

Set reference171 = part1.CreateReferenceFromObject(line2D23)

Set constraint58 = constraints4.AddBiEltCst(catCstTypeTangency, reference170, reference171)

constraint58.Mode = catCstModeDrivingDimension

Set reference172 = part1.CreateReferenceFromObject(circle2D9)

Set reference173 = part1.CreateReferenceFromObject(line2D26)

Set constraint59 = constraints4.AddBiEltCst(catCstTypeTangency, reference172, reference173)

constraint59.Mode = catCstModeDrivingDimension

Set reference174 = part1.CreateReferenceFromObject(circle2D9)

Set constraint60 = constraints4.AddMonoEltCst(catCstTypeRadius, reference174)

constraint60.Mode = catCstModeDrivingDimension

Set length21 = constraint60.Dimension

length21.Value = 75.000000

sketch10.CloseEdition 

part1.InWorkObject = hybridBody7

part1.Update 

length14.Value = 20.000000

length15.Value = 20.000000

length16.Value = 70.000000

length17.Value = 50.000000

length18.Value = 45.000000

Set hybridShapeFill3 = hybridShapeFactory1.AddNewFill()

Set reference175 = part1.CreateReferenceFromObject(sketch10)

hybridShapeFill3.AddBound reference175

hybridShapeFill3.Continuity = 0

hybridBody7.AppendHybridShape hybridShapeFill3

part1.InWorkObject = hybridShapeFill3

part1.Update 

Set hybridShapePlaneOffset6 = hybridShapes2.Item("Plane.3")

Set reference176 = part1.CreateReferenceFromObject(hybridShapePlaneOffset6)

Set hybridShapeDirection15 = hybridShapeFactory1.AddNewDirection(reference176)

Set reference177 = part1.CreateReferenceFromObject(hybridShapeFill3)

Set hybridShapeExtrude9 = hybridShapeFactory1.AddNewExtrude(reference177, -3.000000, 0.000000, hybridShapeDirection15)

hybridShapeExtrude9.SymmetricalExtension = 0

hybridBody7.AppendHybridShape hybridShapeExtrude9

part1.InWorkObject = hybridShapeExtrude9

part1.Update 

Set body7 = bodies1.Add()

part1.Update 

Set shapeFactory1 = part1.ShapeFactory

Set reference178 = part1.CreateReferenceFromName("")

Set closeSurface1 = shapeFactory1.AddNewCloseSurface(reference178)

Set reference179 = part1.CreateReferenceFromObject(hybridShapeExtrude9)

closeSurface1.Surface = reference179

part1.Update 

Set selection1 = partDocument1.Selection

Set visPropertySet1 = selection1.VisProperties

Set hybridShapes3 = hybridShapeBlend1.Parent

Dim bSTR1
bSTR1 = hybridShapeBlend1.Name

selection1.Add hybridShapeBlend1

Set visPropertySet1 = visPropertySet1.Parent

Dim bSTR2
bSTR2 = visPropertySet1.Name

Dim bSTR3
bSTR3 = visPropertySet1.Name

visPropertySet1.SetShow 1

selection1.Clear 

Set selection2 = partDocument1.Selection

Set visPropertySet2 = selection2.VisProperties

Set hybridBodies1 = hybridBody7.Parent

Dim bSTR4
bSTR4 = hybridBody7.Name

selection2.Add hybridBody7

Set visPropertySet2 = visPropertySet2.Parent

Dim bSTR5
bSTR5 = visPropertySet2.Name

Dim bSTR6
bSTR6 = visPropertySet2.Name

visPropertySet2.SetShow 1

selection2.Clear 

Set reference180 = part1.CreateReferenceFromName("")

Set pocket1 = shapeFactory1.AddNewPocketFromRef(reference180, 20.000000)

Set reference181 = part1.CreateReferenceFromObject(sketch1)

pocket1.SetProfileElement reference181

Set limit1 = pocket1.FirstLimit

limit1.LimitMode = catUpToPlaneLimit

Set hybridShapePlaneOffset7 = hybridShapes2.Item("Plane.1")

Set reference182 = part1.CreateReferenceFromObject(hybridShapePlaneOffset7)

limit1.LimitingElement = reference182

part1.UpdateObject pocket1

part1.Update 

partDocument1.SeeHiddenElements = True

Set selection3 = partDocument1.Selection

Set visPropertySet3 = selection3.VisProperties

Set hybridShapes3 = hybridShapeBlend1.Parent

Dim bSTR7
bSTR7 = hybridShapeBlend1.Name

selection3.Add hybridShapeBlend1

Set visPropertySet3 = visPropertySet3.Parent

Dim bSTR8
bSTR8 = visPropertySet3.Name

Dim bSTR9
bSTR9 = visPropertySet3.Name

visPropertySet3.SetShow 0

selection3.Clear 

partDocument1.SeeHiddenElements = False

Set reference183 = part1.CreateReferenceFromName("")

Set closeSurface2 = shapeFactory1.AddNewCloseSurface(reference183)

Set reference184 = part1.CreateReferenceFromObject(hybridShapeBlend1)

closeSurface2.Surface = reference184

part1.Update 

Set reference185 = part1.CreateReferenceFromName("")

Set closeSurface3 = shapeFactory1.AddNewCloseSurface(reference185)

Set reference186 = part1.CreateReferenceFromObject(hybridShapeExtrude2)

closeSurface3.Surface = reference186

part1.Update 

Set reference187 = part1.CreateReferenceFromName("")

Set closeSurface4 = shapeFactory1.AddNewCloseSurface(reference187)

Set reference188 = part1.CreateReferenceFromObject(hybridShapeExtrude1)

closeSurface4.Surface = reference188

part1.Update 

Set reference189 = part1.CreateReferenceFromName("")

Set closeSurface5 = shapeFactory1.AddNewCloseSurface(reference189)

Set reference190 = part1.CreateReferenceFromObject(hybridShapeExtrude4)

closeSurface5.Surface = reference190

part1.Update 

Set reference191 = part1.CreateReferenceFromName("")

Set closeSurface6 = shapeFactory1.AddNewCloseSurface(reference191)

Set reference192 = part1.CreateReferenceFromObject(hybridShapeBlend2)

closeSurface6.Surface = reference192

part1.Update 

Set reference193 = part1.CreateReferenceFromName("")

Set closeSurface7 = shapeFactory1.AddNewCloseSurface(reference193)

Set reference194 = part1.CreateReferenceFromObject(hybridShapeExtrude3)

closeSurface7.Surface = reference194

part1.Update 

Set reference195 = part1.CreateReferenceFromName("")

Set closeSurface8 = shapeFactory1.AddNewCloseSurface(reference195)

Set reference196 = part1.CreateReferenceFromObject(hybridShapeExtrude6)

closeSurface8.Surface = reference196

part1.Update 

Set reference197 = part1.CreateReferenceFromName("")

Set closeSurface9 = shapeFactory1.AddNewCloseSurface(reference197)

Set reference198 = part1.CreateReferenceFromObject(hybridShapeBlend3)

closeSurface9.Surface = reference198

part1.Update 

Set reference199 = part1.CreateReferenceFromName("")

Set closeSurface10 = shapeFactory1.AddNewCloseSurface(reference199)

Set reference200 = part1.CreateReferenceFromObject(hybridShapeExtrude5)

closeSurface10.Surface = reference200

part1.Update 

Set reference201 = part1.CreateReferenceFromName("")

Set closeSurface11 = shapeFactory1.AddNewCloseSurface(reference201)

Set reference202 = part1.CreateReferenceFromObject(hybridShapeExtrude7)

closeSurface11.Surface = reference202

part1.Update 

Set reference203 = part1.CreateReferenceFromName("")

Set closeSurface12 = shapeFactory1.AddNewCloseSurface(reference203)

Set reference204 = part1.CreateReferenceFromObject(hybridShapeExtrude8)

closeSurface12.Surface = reference204

part1.Update 

Set reference205 = part1.CreateReferenceFromName("")

Set closeSurface13 = shapeFactory1.AddNewCloseSurface(reference205)

Set reference206 = part1.CreateReferenceFromObject(hybridShapeSweepExplicit2)

closeSurface13.Surface = reference206

part1.Update 

Set reference207 = part1.CreateReferenceFromName("")

Set closeSurface14 = shapeFactory1.AddNewCloseSurface(reference207)

Set reference208 = part1.CreateReferenceFromObject(hybridShapeSweepExplicit1)

closeSurface14.Surface = reference208

part1.Update 

Set selection4 = partDocument1.Selection

Set visPropertySet4 = selection4.VisProperties

Set hybridBodies1 = hybridBody1.Parent

Dim bSTR10
bSTR10 = hybridBody1.Name

selection4.Add hybridBody1

Set hybridBodies1 = hybridBody2.Parent

Dim bSTR11
bSTR11 = hybridBody2.Name

selection4.Add hybridBody2

Set hybridBodies1 = hybridBody3.Parent

Dim bSTR12
bSTR12 = hybridBody3.Name

selection4.Add hybridBody3

Set hybridBodies1 = hybridBody4.Parent

Dim bSTR13
bSTR13 = hybridBody4.Name

selection4.Add hybridBody4

Set hybridBodies1 = hybridBody5.Parent

Dim bSTR14
bSTR14 = hybridBody5.Name

selection4.Add hybridBody5

Set hybridBodies1 = hybridBody6.Parent

Dim bSTR15
bSTR15 = hybridBody6.Name

selection4.Add hybridBody6

Set visPropertySet4 = visPropertySet4.Parent

Dim bSTR16
bSTR16 = visPropertySet4.Name

Dim bSTR17
bSTR17 = visPropertySet4.Name

visPropertySet4.SetShow 1

selection4.Clear 

Set selection5 = partDocument1.Selection

Set visPropertySet5 = selection5.VisProperties

Set bodies1 = body3.Parent

Dim bSTR18
bSTR18 = body3.Name

selection5.Add body3

Set bodies1 = body5.Parent

Dim bSTR19
bSTR19 = body5.Name

selection5.Add body5

Set bodies1 = body2.Parent

Dim bSTR20
bSTR20 = body2.Name

selection5.Add body2

Set bodies1 = body4.Parent

Dim bSTR21
bSTR21 = body4.Name

selection5.Add body4

Set bodies1 = body6.Parent

Dim bSTR22
bSTR22 = body6.Name

selection5.Add body6

Set bodies1 = body1.Parent

Dim bSTR23
bSTR23 = body1.Name

selection5.Add body1

Set visPropertySet5 = visPropertySet5.Parent

Dim bSTR24
bSTR24 = visPropertySet5.Name

Dim bSTR25
bSTR25 = visPropertySet5.Name

visPropertySet5.SetShow 1

selection5.Clear 

Set sketches11 = body7.Sketches

Set reference209 = part1.CreateReferenceFromName("Selection_RSur:(Face:(Brp:(CloseSurface.11;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))))));None:();Cf11:());CloseSurface.14_ResultOUT;Z0;G4074)")

Set sketch11 = sketches11.Add(reference209)

Dim arrayOfVariantOfDouble5(8)
arrayOfVariantOfDouble5(0) = 0.000000
arrayOfVariantOfDouble5(1) = 4.000000
arrayOfVariantOfDouble5(2) = 0.000000
arrayOfVariantOfDouble5(3) = -1.000000
arrayOfVariantOfDouble5(4) = 0.000000
arrayOfVariantOfDouble5(5) = 0.000000
arrayOfVariantOfDouble5(6) = 0.000000
arrayOfVariantOfDouble5(7) = 0.000000
arrayOfVariantOfDouble5(8) = 1.000000
sketch11.SetAbsoluteAxisData arrayOfVariantOfDouble5

part1.InWorkObject = sketch11

Set factory2D5 = sketch11.OpenEdition()

Set geometricElements20 = sketch11.GeometricElements

Set axis2D5 = geometricElements20.Item("AbsoluteAxis")

Set line2D28 = axis2D5.GetItem("HDirection")

line2D28.ReportName = 1

Set line2D29 = axis2D5.GetItem("VDirection")

line2D29.ReportName = 2

sketch11.CloseEdition 

part1.InWorkObject = sketch11

part1.Update 

Set reference210 = part1.CreateReferenceFromName("Selection_RSur:(Face:(Brp:(CloseSurface.11;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))))));None:();Cf11:());CloseSurface.14_ResultOUT;Z0;G4074)")

Set sketch12 = sketches11.Add(reference210)

Dim arrayOfVariantOfDouble6(8)
arrayOfVariantOfDouble6(0) = 0.000000
arrayOfVariantOfDouble6(1) = 4.000000
arrayOfVariantOfDouble6(2) = 0.000000
arrayOfVariantOfDouble6(3) = -1.000000
arrayOfVariantOfDouble6(4) = 0.000000
arrayOfVariantOfDouble6(5) = 0.000000
arrayOfVariantOfDouble6(6) = 0.000000
arrayOfVariantOfDouble6(7) = 0.000000
arrayOfVariantOfDouble6(8) = 1.000000
sketch12.SetAbsoluteAxisData arrayOfVariantOfDouble6

part1.InWorkObject = sketch12

Set factory2D6 = sketch12.OpenEdition()

Set geometricElements21 = sketch12.GeometricElements

Set axis2D6 = geometricElements21.Item("AbsoluteAxis")

Set line2D30 = axis2D6.GetItem("HDirection")

line2D30.ReportName = 1

Set line2D31 = axis2D6.GetItem("VDirection")

line2D31.ReportName = 2

Set point2D37 = factory2D6.CreatePoint(-80.195351, -10.000000)

point2D37.ReportName = 3

Set point2D38 = factory2D6.CreatePoint(-180.000000, -10.000000)

point2D38.ReportName = 4

Set line2D32 = factory2D6.CreateLine(-80.195351, -10.000000, -180.000000, -10.000000)

line2D32.ReportName = 5

line2D32.StartPoint = point2D37

line2D32.EndPoint = point2D38

Set constraints5 = sketch12.Constraints

Set reference211 = part1.CreateReferenceFromObject(line2D32)

Set reference212 = part1.CreateReferenceFromObject(line2D30)

Set constraint61 = constraints5.AddBiEltCst(catCstTypeHorizontality, reference211, reference212)

constraint61.Mode = catCstModeDrivingDimension

Set point2D39 = factory2D6.CreatePoint(-180.000000, 250.000000)

point2D39.ReportName = 6

Set line2D33 = factory2D6.CreateLine(-180.000000, -10.000000, -180.000000, 250.000000)

line2D33.ReportName = 7

line2D33.StartPoint = point2D38

line2D33.EndPoint = point2D39

Set reference213 = part1.CreateReferenceFromObject(line2D33)

Set reference214 = part1.CreateReferenceFromObject(line2D31)

Set constraint62 = constraints5.AddBiEltCst(catCstTypeVerticality, reference213, reference214)

constraint62.Mode = catCstModeDrivingDimension

Set line2D34 = factory2D6.CreateLine(-180.000000, 250.000000, -80.195351, -10.000000)

line2D34.ReportName = 8

line2D34.StartPoint = point2D39

line2D34.EndPoint = point2D37

Set reference215 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:((Brp:(CloseSurface.11;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(CloseSurface.13;(Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;9)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(G" & "SMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;18)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;12)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Br" & "p:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;17)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;20)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7" & ";(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;15)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;19)))))))));None:();Cf11:());Face:(Brp:(CloseSurface.11;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))))));No" & "ne:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", closeSurface11)

Set geometricElements22 = factory2D6.CreateProjections(reference215)

Set geometry2D16 = geometricElements22.Item("Mark.1")

geometry2D16.Construction = True

Set reference216 = part1.CreateReferenceFromObject(line2D32)

Set reference217 = part1.CreateReferenceFromObject(geometry2D16)

Set constraint63 = constraints5.AddBiEltCst(catCstTypeOn, reference216, reference217)

constraint63.Mode = catCstModeDrivingDimension

Set reference218 = part1.CreateReferenceFromBRepName("FEdge:(Edge:(Face:(Brp:(CloseSurface.11;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))))));None:();Cf11:());Face:(Brp:(CloseSurface.11;(Brp:(GSMExtrude.7;1)));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithPermanentBody;WithoutBuildError;WithInitialFeatureSupport;MonoFond;MFBRepVersion_CXR15)", closeSurface11)

Set geometricElements23 = factory2D6.CreateProjections(reference218)

Set geometry2D17 = geometricElements23.Item("Mark.1")

geometry2D17.Construction = True

Set reference219 = part1.CreateReferenceFromObject(line2D33)

Set reference220 = part1.CreateReferenceFromObject(geometry2D17)

Set constraint64 = constraints5.AddBiEltCst(catCstTypeOn, reference219, reference220)

constraint64.Mode = catCstModeDrivingDimension

Set geometricElements24 = factory2D6.CreateIntersections(reference46)

Set geometry2D18 = geometricElements24.Item("Mark.1")

geometry2D18.Construction = True

Set reference221 = part1.CreateReferenceFromObject(geometry2D18)

Set reference222 = part1.CreateReferenceFromObject(point2D39)

Set constraint65 = constraints5.AddBiEltCst(catCstTypeDistance, reference221, reference222)

constraint65.Mode = catCstModeDrivingDimension

Set length22 = constraint65.Dimension

length22.Value = 260.000000

Set reference223 = part1.CreateReferenceFromObject(line2D34)

Set reference224 = part1.CreateReferenceFromObject(line2D33)

Set constraint66 = constraints5.AddBiEltCst(catCstTypeAngle, reference223, reference224)

constraint66.Mode = catCstModeDrivingDimension

constraint66.AngleSector = catCstAngleSector2

Set angle3 = constraint66.Dimension

angle3.Value = 21.000000

sketch12.CloseEdition 

part1.InWorkObject = sketch12

part1.Update 

length22.Value = 260.000000

length22.Value = 260.000000

Set pocket2 = shapeFactory1.AddNewPocket(sketch12, 20.000000)

Set limit2 = pocket2.FirstLimit

limit2.LimitMode = catUpToPlaneLimit

limit2.LimitMode = catOffsetLimit

pocket2.IsSymmetric = True

part1.UpdateObject pocket2

part1.Update 

Set reference225 = part1.CreateReferenceFromName("")

Set constRadEdgeFillet1 = shapeFactory1.AddNewSolidEdgeFilletWithConstantRadius(reference225, catTangencyFilletEdgePropagation, 5.000000)

Set reference226 = part1.CreateReferenceFromBRepName("TgtEdge:(GeneratedEdges;MfIE_R20GA;TgtPropagationFillet;FirstOperands:(Pocket.2);SecondOperands:();InitEdges:(REdge:(Edge:(Face:(Brp:(Pocket.2;0:(Brp:(Sketch.12;8)));None:();Cf11:());Face:(Brp:((Brp:(CloseSurface.11;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(CloseSurface.13;(Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep" & ".2_GSMPositionTransfo.1;(Brp:(Sketch.8;9)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;18)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSw" & "eep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;12)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;17)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(G" & "SMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;20)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;15)))));Brp:(GSMSweep.2;1:(Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;13)))))));Br" & "p:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;19)))))))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithTemporaryBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)))", pocket2)

constRadEdgeFillet1.AddObjectToFillet reference226

constRadEdgeFillet1.EdgePropagation = catTangencyFilletEdgePropagation

Set parameters1 = part1.Parameters

Set length23 = parameters1.Item("FW-zero\Body.8\EdgeFillet.1\CstEdgeRibbon.1\Radius")

length23.Value = 25.000000

part1.Update 

Set reference227 = part1.CreateReferenceFromName("")

Set constRadEdgeFillet2 = shapeFactory1.AddNewSolidEdgeFilletWithConstantRadius(reference227, catTangencyFilletEdgePropagation, 25.000000)

Set reference228 = part1.CreateReferenceFromBRepName("TgtEdge:(GeneratedEdges;MfIE_R20GA;TgtPropagationFillet;FirstOperands:(Pocket.2);SecondOperands:();InitEdges:(REdge:(Edge:(Face:(Brp:(CloseSurface.11;(Brp:(GSMExtrude.7;1)));None:();Cf11:());Face:(Brp:(Pocket.2;0:(Brp:(Sketch.12;8)));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithTemporaryBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)))", constRadEdgeFillet1)

constRadEdgeFillet2.AddObjectToFillet reference228

constRadEdgeFillet2.EdgePropagation = catTangencyFilletEdgePropagation

part1.Update 

Set reference229 = part1.CreateReferenceFromName("")

Set constRadEdgeFillet3 = shapeFactory1.AddNewSolidEdgeFilletWithConstantRadius(reference229, catTangencyFilletEdgePropagation, 25.000000)

Set reference230 = part1.CreateReferenceFromBRepName("TgtEdge:(GeneratedEdges;MfIE_R20GA;TgtPropagationFillet;FirstOperands:(CloseSurface.13);SecondOperands:();InitEdges:(REdge:(Edge:(Face:(Brp:((Brp:(CloseSurface.13;(Brp:(GSMSweep.2;(Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;17)));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)))));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))))))));Brp:(CloseSurface.14;(Brp:(GSMSweep.1;(Brp:(GSMSwee" & "p.1_GSMPositionTransfo.1;(Brp:(Sketch.8;17)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;22)))));Brp:(FeatureREDGE.1;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;22)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)))))))));None:();Cf11:());Face:(Brp:(CloseSurface.13;(Brp:(GSMSweep.2;(Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;12)));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(" & "GSMExtrude.7;(Brp:(GSMPlane.8)))));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))))))));None:();Cf11:());None:(Limits1:();Limits2:());Cf11:());WithTemporaryBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)))", constRadEdgeFillet2)

constRadEdgeFillet3.AddObjectToFillet reference230

constRadEdgeFillet3.EdgePropagation = catTangencyFilletEdgePropagation

Set parameters2 = part1.Parameters

Set length24 = parameters2.Item("FW-zero\Body.8\EdgeFillet.3\CstEdgeRibbon.3\Radius")

length24.Value = 7.000000

part1.Update 

Set reference231 = part1.CreateReferenceFromName("")

Set constRadEdgeFillet4 = shapeFactory1.AddNewSolidEdgeFilletWithConstantRadius(reference231, catTangencyFilletEdgePropagation, 7.000000)

Set reference232 = part1.CreateReferenceFromBRepName("RSur:(Face:(Brp:((Brp:(CloseSurface.13;(Brp:(GSMSweep.2;(Brp:(GSMSweep.2_GSMPositionTransfo.1;(Brp:(Sketch.8;19)));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(FeatureREDGE.2;(Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;15)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)))))));Brp:(CloseSurface.14;(Brp:(GSMSweep.1;(Brp:(GSMSweep.1_GSMPositionTransfo.1;(Brp:(Sketch.8;19)));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)));Brp:(FeatureREDGE.1;(Brp:(GSMExtrude.7;0" & ":(Brp:(GSMFill.1;(Brp:(Sketch.7;22)))));Brp:(GSMExtrude.7;(Brp:(GSMPlane.8)))));Brp:(GSMExtrude.7;0:(Brp:(GSMFill.1;(Brp:(Sketch.7;22)))))))))));None:();Cf11:());WithTemporaryBody;WithoutBuildError;WithSelectingFeatureSupport;MFBRepVersion_CXR15)", constRadEdgeFillet3)

constRadEdgeFillet4.AddObjectToFillet reference232

constRadEdgeFillet4.EdgePropagation = catTangencyFilletEdgePropagation

Set parameters3 = part1.Parameters

Set length25 = parameters3.Item("FW-zero\Body.8\EdgeFillet.4\CstEdgeRibbon.4\Radius")

length25.Value = 1.000000

part1.Update 

Set reference233 = part1.CreateReferenceFromObject(hybridShapePlaneOffset7)

Set mirror1 = shapeFactory1.AddNewMirror(reference233)

part1.Update 

End Sub
