# A-Content-based-Image-Query-System
To run the system, you just need to use matlab open the ly2324.m in the src folder and run it.

Then a GUI will pop out. Instructions:

1. Click the Open Query Image button and you can choose a query image file

2. Click the Candidate Image Dir button, then you can choose the folder containing the candidate images. Note that the names of those images need to be index.jpg

3. Click the Build Feature Matrix button, then the system will start extracting features from the candidate image dir. Note that if there exists the data.mat file containing features, you don't need to compute it again.

4. Click the start query button, then the system will start finding the matched images. And the chosen indexes will be shown in the listbox. You can click items in listbox to make the corresponding image shown.

There is a default data.mat. You can start querying without do the pre-computation stage.
