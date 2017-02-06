package com.siping.web.utility;

import java.util.Random;  
/**
 * 用于生成八位随机且不重复的纯数字邀请码  
 * @author SP
 *
 */
public class RandomInvationUtil {  
    private Random random;  
    private String table;  
    public RandomInvationUtil() {  
        random = new Random();  
        table = "0123456789";  
    }  
    public String randomInvation(int id) {  
        String ret = null,  
            num = String.format("%05d", id); 
        int key = random.nextInt(10),   
            seed = random.nextInt(100);  
        CaesarUtil caesar = new CaesarUtil(table, seed);  
        num = caesar.encode(key, num);  
        ret = num   
            + String.format("%01d", key)   
            + String.format("%02d", seed);    
        return ret;  
    }     
}  