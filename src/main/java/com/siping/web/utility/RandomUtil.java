package com.siping.web.utility;

import java.util.Random;

import org.apache.log4j.Logger;

public class RandomUtil {

	Logger logger = Logger.getLogger(RandomUtil.class);

	private static RandomUtil instance;
  
	public RandomUtil() {
		if (instance == null) {
			getInstance();
		}
	}

	public static RandomUtil getInstance() {
		return new RandomUtil();
	}

	public static String getRandomNumber(int lenght) { 
		int[] array = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
		Random rand = new Random();
		for (int i = 10; i > 1; i--) {
			int index = rand.nextInt(i);
			int tmp = array[index];
			array[index] = array[i - 1];
			array[i - 1] = tmp;
		}
		int result = 0;
		for (int i = 0; i < lenght; i++)
			result = result * 10 + array[i]; 

		return Integer.toString(result);
	}

	public static String getRandomCharacter(int length) {
		StringBuffer str = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num"; // 输出字母还是数字

			if ("char".equalsIgnoreCase(charOrNum)) // 字符串
			{
				int choice = random.nextInt(2) % 2 == 0 ? 65 : 97; // 取得大写字母还是小写字母
				str.append((char) (choice + random.nextInt(26)));
			} else if ("num".equalsIgnoreCase(charOrNum)) // 数字
			{
				str.append(String.valueOf(random.nextInt(10)));
			}
		}

		return str.toString();
	}

	public static void main(String[] args) {
		System.out.println(RandomUtil.getRandomNumber(3));
		System.out.println(RandomUtil.getRandomCharacter(6));
	}

}
