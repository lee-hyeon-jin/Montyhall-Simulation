package com.montyhall.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class MontyHallService {
    public boolean playGame(boolean switchChoice) {
        List<Integer> doors = new ArrayList<>();
        doors.add(0); // goat
        doors.add(0); // goat
        doors.add(1); // car
        Collections.shuffle(doors);

        // 플레이어 첫번째 선택
        int playerChoice = (int) (Math.random() * 3);

        // 플레이어가 선택하지 않은 염소가 있는 문을 공개
        int hostReveal;
        do {
            hostReveal = (int) (Math.random() * 3);
        } while (hostReveal == playerChoice || doors.get(hostReveal) == 1);

        // 플레이어가 선택을 바꾸면, 남은 수를 playerChoice에 저장
        if (switchChoice) {
            for (int i = 0; i < 3; i++) {
                if (i != playerChoice && i != hostReveal) {
                    playerChoice = i;
                    break;
                }
            }
        }

        // 만약 당첨을 선택했다면 true, 아니라면 false 출력 (위에서 0은 goat, 1은 car로 선언해놓음)
        return doors.get(playerChoice) == 1;
    }
}
