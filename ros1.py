#!/usr/bin/env python  # 이게 있어야 python 파일임

import rospy # ros에서 python coding하기위해 반드시 불러와야됨

# Brings in the SimpleActionClient
import actionlib # Client가 보낸 요청된 목표를 실행해주는 도구 제공하는 라이브러리 (조금 더 알아보기...)
# Brings in the .action file and messages used by the move base action
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal # move_base_msgs.msg에 있는 메시지 타입 중 MoveBaseAction, MoveBaseGoal를 불러옴.
# move_base_msgs.msg 관련 자료 : http://docs.ros.org/en/electric/api/move_base_msgs/html/index-msg.html

def movebase_client(): # movebase_client 함수 정의 부분
    # Create an action client called "move_base" with action definition file "MoveBaseAction"
    client = actionlib.SimpleActionClient('move_base', MoveBaseAction) # 생성자 함수 실행에 필요한 인자 입력?
    # SimpleActionClient class 관련 자료 1 : https://docs.ros.org/en/api/actionlib/html/classactionlib_1_1simple__action__client_1_1SimpleActionClient.html
    # SimpleActionClient class 관련 자료 2 : https://docs.ros.org/en/api/actionlib/html/simple__action__client_8py_source.html
    # 생성자 함수 : Constructs a SimpleActionClient and opens connections to an ActionServer.
    # 'move_base' : namespace
    # MoveBaseAction : Action message type. SimpleActionClient는 이 유형의 다른 메시지 유형을 가져옴(?)

    # Waits until the action server has started up and started listening for goals.
    client.wait_for_server() # action server가 이 파일(client)과 연결될때까지 기다림

    # Creates a new goal with the MoveBaseGoal constructor
    goal = MoveBaseGoal()
    # MoveBaseGoal() 관련 자료 : http://docs.ros.org/en/diamondback/api/move_base_msgs/html/msg/MoveBaseGoal.html
    # move_base_msgs.msg에 있는 메시지 타입 중 하나인 MoveBaseGoal message를 이용해 goal이라는 instance 생성
    # C++의 개념으로 생각하면 MoveBaseGoal이라는 class를 이용하여 goal이라는 instance를 생성했다라고 보면 쉬움

    goal.target_pose.header.frame_id = "map"
    goal.target_pose.header.stamp = rospy.Time.now()  # 현재 시간을 나타내는 새로운 instance 생성
    # rospy.Time.now() 관련 자료 : https://docs.ros.org/en/diamondback/api/rospy/html/rospy.rostime-pysrc.html#Time.now

    # Move 0.5 meters forward along the x axis of the "map" coordinate frame
    goal.target_pose.pose.position.x = 0.5
    # No rotation of the mobile base frame w.r.t. map frame
    goal.target_pose.pose.orientation.w = 1.0

    # Sends the goal to the action server.
    client.send_goal(goal) # ActionServer로 goal을 보냄.
    # 만약 이 함수가 호출됐을 때 이전의 goal이 이미 활성화돼있는 경우,
    # Waits for the server to finish performing the action.
    wait = client.wait_for_result() # Client의 목표가 완전히 수행될 때까지 기다림(Blocks until this goal transitions to done.)
    # 수행완료되면 wait에 1을 반환

    # If the result doesn't arrive, assume the Server is not available
    if not wait: # 수행완료되지 않은 경우 실행
        rospy.logerr("Action server not available!")
        # 관련 자료 : http://wiki.ros.org/rospy/Overview/Logging 中 (These log messages are human-readable string messages that convey the status of a node.)
        rospy.signal_shutdown("Action server not available!")
        # 관련 자료 : http://wiki.ros.org/rospy/Overview/Initialization%20and%20Shutdown
        # rospy.signal_shutdown(reason) : Initiate node shutdown. reason is a human-readable string that documents why a node is being shutdown.
    else: # 수행완료된 경우 실행
        # Result of executing the action
        return client.get_result() # Gets the Result of the current goal.

# If the python node is executed as main process (sourced directly)
if __name__ == '__main__': # 이 파일이 메인 프로그램으로 사용될 때와 모듈로 사용될 때를 구분하기 위한 용도. 현재 프로그램이 메인 프로그램으로 사용될 경우에만 아래 명령 실행
    # 관련 자료 : https://dojang.io/mod/page/view.php?id=2448

    # try except (예외처리) 관련 자료 : https://blog.naver.com/wizardry0629/222133200624, https://blog.naver.com/kmy6976/222071706510, https://blog.naver.com/pisibook/221704361106
    try:
        # Initializes a rospy node to let the SimpleActionClient publish and subscribe
        rospy.init_node('movebase_client_py') # movebase_client_py node 초기화(rospy에게 코드 이름이 movebase_client_py라고 알려줌. 이렇게 해줘야 통신 시작.)
        # 관련 자료 : https://m.blog.naver.com/PostView.nhn?blogId=passionvirus&logNo=80130186966&proxyReferer=https:%2F%2Fwww.google.com%2F
        result = movebase_client() # movebase_client 함수 실행. return 값(54 line)을 result에 할당.
        if result: # result값이 true(1) 일 경우 아래 명령 실행
            rospy.loginfo("Goal execution done!") # rospy.logerr()와 같은 함수
    except rospy.ROSInterruptException: # rospy.ROSInterruptException 오류 발생 시 아래 명령 실행
        rospy.loginfo("Navigation test finished.") # rospy.logerr()와 같은 함수