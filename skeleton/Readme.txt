1) cvpr_computedescriptors 

1. "GlobalColourHistogram(img,M)", 
2. "F1=Grid_MeanColour(img, M)", 
3. "F2=Grid_EdgeOrientationHistogram(img,M,A)",
4. "Grid_Edge_MeanColour_Histogram(F1,F2,M)".  
 
Choose one of 1, 2 or 3 discriptor
If want to use the fourth discriptor, it must contain the second and the third discriptor.

'M' represents M*M grids
'A' represents A angular quatization level 

2) cvpr_visualsearch 
Pick random image as query image. Return top 19 images, PR Curve and classified percision.

3)cvpr_Allclass_visualsearch
Pick the first image of each class. Return 20 PR Curves of each class and each classified percision.

4)cvpr_compare

choose any distance you want. L1 norm, L2 norm or Chebyshev distance.

if want to use PCA + Mahalanobis distance, go to one of the "cvpr_visualsearch" or "cvpr_Allclass_visualsearch" .

Active the 67th line.
Blind  the 75th to 78th lines.
Active the 82th to 85th lines.

if only want to use PCA + L1 norm, L2 norm or Chebyshev distance.
Active the 67th line.
Active  the 75th to 78th lines.
Blind the 82th to 85th lines.