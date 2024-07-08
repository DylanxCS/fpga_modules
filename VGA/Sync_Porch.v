//Whole area -> 800x525, Visible area -> 640x480
//Hsync -> front: 18, back: 50, pulse: 92
//Vsync -> front: 10, back: 33, pulse: 2

//Sync pulse gives 1 for visible area then 0 for the rest
//This module should alter the Sync_pulse signal to include the front & back porch

//GOAL: convert hsync porch pixel values to clock cycles
//RECALL: 60 clock cycles per pixel. Each row contains 800 pixels.
//RECALL: 48000 clock cycles per row -> 60*800

//Hsync -> front: 1080, back: 3000, pulse: 5520
//Vsync -> front: 600, back: 1980, pulse 120

