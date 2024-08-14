package com.montyhall.controller;

import com.montyhall.service.MontyHallService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MontyHallController {

    @Autowired
    private MontyHallService montyHallService;

    @GetMapping("/montyhall")
    public String playGame(@RequestParam(name="switch", required=false, defaultValue="false") boolean switchChoice, Model model) {
        boolean result = montyHallService.playGame(switchChoice);
        model.addAttribute("result", result);
        model.addAttribute("switchChoice", switchChoice);
        return "montyhall";
    }
}
