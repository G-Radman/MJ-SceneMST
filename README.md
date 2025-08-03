# MJ-SceneMST

This repository includes data, code and stimulus material for a validated set of images prepared for use in Mnemonic Similarity Task (MST; Stark et al., 2015). This stimulus set was created independent from the authors of the original MST, and was validated using a 2AFC response format as opposed to 3AFC. The images are available in three resolutions: the original 1024x1024 pixel, 800x800 pixels, and 612 x 612 pixels.

--- Set up of the image set and its validation ---
In total the final image set includes 468 images covering 156 unique scene categories. For each category, there are three image pairs available across three categorical levels of similarity: high, moderate, low. Initially, refinements (i.e. choosing or generating new images) were made of the stimulus set based on data from two independent raters rating the perceived similarity of each image pair. In the next iteration, 15 independent raters rated the perceptual similarity of new image set, resulting in exclusion of some categories still failing to show on average the high > moderate > low order of similarity ratings (essentially, we were striving to maintain, and verify, a categorical distinction of high, moderate and low similarity pair for each category).

Testing mnemonic similarity, we next used a modified MST with only the response alternatives "Old" and "New" given a high degree of semantic overlap between naturalistic scenes complicating interpretation of traditionally "similar" responses. This was made on 48 older adults and 42 younger adults (after some exclusion due to chance-level performance) recruited through Prolific. Participants were unaware of subsequent memory testing during encoding, being tasked instead to rate the images for level of realism. This on the one hand allowed us to seamlessly collect realism ratings for each image, and encouraged engagement with the images during the encoding phase.

Image 1 from each image pair was always used as the "Target" image, and Image 2 always used as the corresponding "Lure" image. To balance the two response alternatives (Old vs. New), 78/156 images were presented at encoding and subsequently tested as targets, 39 images were presented at encoding but replaced with lures at retrieval, and 39 images were not presented at encoding but introduced as "Foil" images at retrieval. To accomplish validating each image (i.e. allowing each image to be replaced with a corresponding Lure), we generated 12 unique image set, which rotated the roles (rotation setup available in "Set_design.xlsx").

Finally, we rebalanced the 12 original sets based on the d-prime Lure index of the included images: P(Lure | Old), aiming to create 12 sets with as comparable mnemonic similarity as possible.

--- Included in the repository ---
- Images in three pixel sizes (1024x1024, 800x800, 612x612) 
- Data (both raw and summarized) showing the performance for each image and set, along with associated code
- Rebalanced 12 set version (and associated code for how this was generated)
- Example code for running the experiment in PsychoPy using the 12 set version
- A single set created with the purpose of having as good of a continuous variable for perceptual similarity as possible (with associated code for how this was generated).

--- Copyright and use ---
This stimulus repository is free to use for anyone. The authors are not responsible for errors in usage or in code provided as example for how to run.

For questions, please contact gustaf.radman@med.lu.se
