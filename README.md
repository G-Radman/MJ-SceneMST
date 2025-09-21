# MJ-SceneMST
This repository provides a validated set of images for use in the Mnemonic Similarity Task (MST; Stark et al., 2015). Resources are currently in preparation. At present, the images are available; data and relevant code will be released shortly.

## To be included in the repository
- Images in three pixel sizes (1024×1024, 800×800, 612×612)  
- Data (both raw and summarized) showing the performance for each image and set, along with associated code  
- Rebalanced 12-set version with predefined roles for each included image pair (and associated code for how this was generated)  
- Example code for running an experiment in PsychoPy using the 12-set version  
- A single set designed to provide a strong continuous variable for perceptual similarity (with associated code for how this was generated)  

## Set up of the image set and its validation
This stimulus set was created independently from the authors of the original MST and was validated using a 2AFC (Old vs. New) response format, rather than the traditional 3AFC (Old, New, Similar). The images are available in three resolutions: 1024×1024 pixels, 800×800 pixels, and 612×612 pixels.

The final image set includes 936 images covering 156 unique scene categories at three similarity levels: high, moderate, and low. Initially, refinements were made based on data from two independent raters who judged the perceived similarity of each image pair. In the next iteration, 15 independent raters evaluated perceptual similarity, leading to the exclusion of categories that failed to reliably show the expected order (high > moderate > low). The goal was to preserve and verify a clear categorical distinction among the three similarity levels for each category.

To test mnemonic similarity, we used a modified MST with only the response alternatives “Old” and “New,” due to the high semantic overlap among naturalistic scenes, which complicates interpretation of traditional “Similar” responses. This study included 49 older adults and 47 younger adults recruited through Prolific (one younger adult was excluded for below chance-level performance). During encoding, participants were unaware of the subsequent memory test and instead rated each image for realism. This design both collected realism ratings and encouraged engagement with the images during encoding.

Image 1 from each pair was always used as the **Target**, and Image 2 as the corresponding **Lure**. To balance the two response alternatives (Old vs. New), 78 of the 156 images were presented at encoding and later tested as targets, 39 were presented at encoding but replaced with lures at retrieval, and 39 were not shown at encoding but introduced as **Foils** at retrieval. To validate each image (i.e., ensuring each could be used as a Lure), we generated 12 unique image sets and rotated the roles and similarity levels.

Finally, we rebalanced the 12 original sets to create new sets with comparable memory performance. Image pairs were assigned to predefined roles across sets, balancing the associated performance metrics:  
- Lures: P(Old | Lure)  
- Targets: P(New | Target)  
- Foils: P(Old | Foil)  

## Copyright and use
This stimulus repository is publicly available and free to use. The authors are not responsible for errors in usage or in the example code provided.

For questions, please contact: **gustaf.radman@med.lu.se**
