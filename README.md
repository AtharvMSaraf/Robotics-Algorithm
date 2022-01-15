# Robotics-Algorithm
These are the assignment submitted for the CSE548 robotics algorithms 

Marks Obtained for these projects are:-
  a] lab1 - 15/15
  b] lab2 - 15/15
  c] lab3 - 15/15
  d] lab4 - 15/15
  
**Project Description**:-

1] **Evader Controller** :

    Wrote a controller node that drives the robot straight at a constant speed of 2m/s. When the robot is close to an obstacle, it turned in a random new direction, and continue driving.

2] **Laser-Based Perception and Navigation with Obstacle Avoidance**

    A] **Perception Using Laser Range Finder**:- 

      For this section, we had to implement the RANSAC algorithm to determine the walls “visible” to the robot from the data obtained from the laser range finder. My program took the laser scans as inputs and output a set of lines seen by the robot identifying the obstacles in view.
    
    B] **Bug2 algorithm**:-

    For this portion, we implement the bug2 algorithm. We made the robot start at (-8.0, -2.0) and it should plan its path to (4.5, 9.0) or any other goal location. The robot will have to navigate itself avoiding the various obstacles in its way.
  
  
3] **Colorizing the Prokudin-Gorskii photo collection**:-

    Part1:
  
    My program took a glass plate image as input and produce a single color image as output. The program divided the image into three equal parts and align the second and the third parts (G and R) to the first (B). For each image, I also printed the (x,y) displacement vector that was used to align the parts
 
    Part 2:  **Feature Based Alignment**:
 
      In this we computed the cornerness function on an image, and chooses the top 200 features in the given image. Created another file called im_align3.m that runs the RANSAC algorithm. The algorithm randomly picks a feature in image 1 (lets say the B channel image) and assumes it aligns with a random feature in image 2 (lets say, the G channel image). After which  we Calculated the pixel shift for this alignment. Then apply the same pixel shift to every feature in image 1, and search for a corresponding feature in image 2 within a threshold (a small window). If i found a feature within that window, I counted it as an inlier; else it is not. I ran this several times, and pick the best alignment (highest number of inliers). So the output was this alignment, along with an aligned color image

4] **Path Planning**:-

    The objective of this assignment is to plan a path for a robot from a given starting point to a destination. I used A* planning algorithm to find a route from a default start point (-8.0, -2.0) to a default goal (4.5, 9.0). The occupancy grid map was given and the heuristics function used for this project was eulers distnace.
