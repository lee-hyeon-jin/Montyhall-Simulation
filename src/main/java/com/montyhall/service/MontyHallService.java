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

        // Player's initial choice
        int playerChoice = (int) (Math.random() * 3);

        // Host reveals a goat door that was not chosen by the player
        int hostReveal;
        do {
            hostReveal = (int) (Math.random() * 3);
        } while (hostReveal == playerChoice || doors.get(hostReveal) == 1);

        // If the player switches, they change their choice to the remaining door
        if (switchChoice) {
            for (int i = 0; i < 3; i++) {
                if (i != playerChoice && i != hostReveal) {
                    playerChoice = i;
                    break;
                }
            }
        }

        // Return true if the player wins the car, false otherwise
        return doors.get(playerChoice) == 1;
    }
}
