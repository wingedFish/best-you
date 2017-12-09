package github.wingedfish.best.controller;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@EnableAutoConfiguration
@Controller
public class BestYouController {

    @RequestMapping("/best")
    @ResponseBody
    String best(){
        return "for you best life!";
    }

    @RequestMapping("/")
    String index(Model model){
        model.addAttribute("userPin","xhli");
        return "index";
    }

    public static void main(String[] args) {
        SpringApplication.run(BestYouController.class,args);
    }
}
