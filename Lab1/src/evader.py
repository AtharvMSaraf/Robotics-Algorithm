#!/usr/bin/env python

import rospy
from sensor_msgs.msg import LaserScan
from ackermann_msgs.msg import AckermannDrive, AckermannDriveStamped
import random

def race(data):
    front_distance=data.ranges[523:555]
    rear_distance1=data.ranges[1065:1080]
    rear_distance2=data.ranges[0:15] #[0,15]
    rear_distance=rear_distance1+rear_distance2

    #------------------ logic for running a single lab---------------------------

    if min(data.ranges)<0.15:#-----------------------------------------------------------------------hand break when very close to the wall
        speed=AckermannDrive(speed=0.0,steering_angle_velocity=0,steering_angle=0)
    
    elif  min(front_distance)<3.8 and min(data.ranges[807:810])>1.25: 
            speed=AckermannDrive(speed=1.5,steering_angle_velocity=-0.0,steering_angle=0.46)

    elif min(front_distance)<1.5 and min(data.ranges[267:268])<0.8:
            speed=AckermannDrive(speed=1.5,steering_angle_velocity=-0.0,steering_angle=0.46)

    elif min(data.ranges[267:268])  <0.5:
        speed=AckermannDrive(speed=1.5,steering_angle_velocity=-0.0,steering_angle=0.2)
    
    elif min(data.ranges[807:810]) <0.5:
        speed=AckermannDrive(speed=1.5,steering_angle_velocity=-0.0,steering_angle=-0.2)
     
    else:
        angle_dir=0
        speed=AckermannDrive(speed=2.0)
    
    evader_publisher.publish(AckermannDriveStamped(drive=speed)) #-----------------------------------------------------final publish command------------------



if __name__=="__main__":
    rospy.init_node('evader',anonymous=True) #--------------------------------------------------------------------------creating a evader node------------------
    evader_publisher=rospy.Publisher('/evader_drive',AckermannDriveStamped,queue_size=10) #-----------------------------creating a publiher, publishing to evader_drive topic----------
    rospy.Subscriber('/scan',LaserScan,race) #--------------------------------------------------------------------------creating a subscriber which subcribes to the /scan topic-----------
    rospy.spin()    
