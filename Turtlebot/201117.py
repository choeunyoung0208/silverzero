#!/usr/bin/env python  # 이게 있어야 python 파일임

import rospy # ros에서 python coding하기위해 반드시 불러와야됨

# Brings in the SimpleActionClient
import actionlib # Client가 보낸 요청된 목표를 실행해주는 도구 제공하는 라이브러리 (조금 더 알아보기...)
# Brings in the .action file and messages used by the move base action
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal # move_base_msgs.msg에 있는 메시지 타입 중 MoveBaseAction, MoveBaseGoal를 불러옴.

def movebase_client(): # movebase_client 함수 정의 부분
    # Create an action client called "move_base" with action definition file "MoveBaseAction"
    client = actionlib.SimpleActionClient('move_base', MoveBaseAction) # https://docs.ros.org/en/api/actionlib/html/classactionlib_1_1simple__action__client_1_1SimpleActionClient.html

    # Waits until the action server has started up and started listening for goals.
    client.wait_for_server()

    # Creates a new goal with the MoveBaseGoal constructor
    goal = MoveBaseGoal()
    goal.target_pose.header.frame_id = "map"
    goal.target_pose.header.stamp = rospy.Time.now()
    # Move 0.5 meters forward along the x axis of the "map" coordinate frame
    goal.target_pose.pose.position.x = 0.5
    # No rotation of the mobile base frame w.r.t. map frame
    goal.target_pose.pose.orientation.w = 1.0

    # Sends the goal to the action server.
    client.send_goal(goal)
    # Waits for the server to finish performing the action.
    wait = client.wait_for_result()
    # If the result doesn't arrive, assume the Server is not available
    if not wait:
        rospy.logerr("Action server not available!")
        rospy.signal_shutdown("Action server not available!")
    else:
        # Result of executing the action
        return client.get_result()

    # If the python node is executed as main process (sourced directly)


if __name__ == '__main__':
    try:
        # Initializes a rospy node to let the SimpleActionClient publish and subscribe
        rospy.init_node('movebase_client_py')
        result = movebase_client()
        if result:
            rospy.loginfo("Goal execution done!")
    except rospy.ROSInterruptException:
        rospy.loginfo("Navigation test finished.")