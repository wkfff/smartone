package com.siping.web.utility;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Component;

import com.siping.system.bean.License;

@Component
public class LicenseUtil {

    public static String propertiesPath = "/WEB-INF/conf/property.properties";

    /**
     * 判断产品是否激活
     * @param license
     * @return
     * @throws Exception
     */
    public boolean judgeLicense(License license) throws Exception {
        boolean flag = true;

        if(license.getMacAddr().equals(encodeMacAddr(getMacAddress()))){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            Date date = new Date();
            Date endDate = sdf.parse(this.encodeDateBack(license.getEncodeEndDate(), 4).substring(5, 13));
            if (endDate.after(date)) {
                flag = true;
            } else {
                flag = false;
            }
        }else{
            flag = false;
        }
        
        
        return flag;
    }

    /**
     * 激活
     * @param context,license
     * @return
     */
    public String checkLicense(License license) {
        if (license == null || "".equals(license.getLicenseKey())) {
            return "无效激活码";
        }

        if (license.getStartDate() == null || license.getEndDate() == null || "".equals(license.getStartDate()) || "".equals(license.getEndDate())) {
            return "无效激活码";
        }

        if (license.getActivateType() == 1 && license.getStatus() != null && license.getStatus() == 1) {
            return "该注册码已被激活";
        }

        Date date = new Date();
        if (license.getEndDate().before(date)) {
            return "该注册码已过期";
        }

        license.setEncodeStartDate(this.encodeDate(license.getStartDate(), 1));
        license.setEncodeEndDate(this.encodeDate(license.getEndDate(), 4));

        return "Y";
    }

    public String updatePropertiesFile(ServletContext context, License license) throws Exception {
        String result = "Y";
        String url = context.getRealPath(propertiesPath);
        Properties properties = new Properties();
        try {
            OutputStream outputStream = new FileOutputStream(url.replace("/", "//"));
            properties.setProperty("PK326", license.getLicenseKey());
            properties.setProperty("MS548", license.getEncodeStartDate());
            properties.setProperty("LE679", license.getEncodeEndDate());
            properties.setProperty("MC103", encodeMacAddr(getMacAddress()));
            properties.store(outputStream, "author: www.siping.com");
            outputStream.close();
        } catch (IOException e) {
            result = e.getMessage();
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 读取properties LicenseKey信息
     * @param request
     * @return
     * @throws Exception
     */
    public void getLicenseByProperties(ServletContext context, License license) {
        String url = context.getRealPath(propertiesPath);

        Properties prop = new Properties();
        try {
            InputStream in = new BufferedInputStream(new FileInputStream(url.replace("/", "//")));
            prop.load(in);
            in.close();
            license.setLicenseKey(prop.getProperty("PK326"));
            license.setEncodeStartDate(prop.getProperty("MS548"));
            license.setEncodeEndDate(prop.getProperty("LE679"));
            license.setMacAddr(prop.getProperty("MC103"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String encodeBack(String s) {
        byte abyte0[] = s.getBytes();
        char ac[] = new char[s.length()];

        int addVar = 48;
        for (int i = 0; i < abyte0.length; i++) {
            int j = abyte0[i];
            if (i < 6) {
                if (i % 2 == 0) {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 1 + 48;
                } else {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 3 + 48;
                }
            } else if (i >= 6 && i < 12) {
                if (i % 3 == 0) {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 5 + 48;
                } else {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 2 + 48;
                }
            } else if (i >= 12 && i < 17) {
                if (i % 2 == 0) {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 4 + 48;
                } else {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 6 + 48;
                }
            } else if (i >= 17 && i < 23) {
                if (i % 2 == 0) {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 2 + 48;
                } else {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 5 + 48;
                }
            } else {
                if (i % 2 == 0) {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 3 + 48;
                } else {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 1 + 48;
                }
            }
            ac[i] = (char) j;
        }
        return String.valueOf(ac);
    }

    public String encodeDateBack(String s, int var) {
        byte abyte0[] = s.getBytes();
        char ac[] = new char[s.length()];

        int addVar = 48;
        for (int i = 0; i < abyte0.length; i++) {
            int j = abyte0[i];
            if (i < 4) {
                if (i % 2 == 0) {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 1 - var + 48;
                } else {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 3 - var + 48;
                }
            } else if (i >= 4 && i < 9) {
                if (i % 3 == 0) {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 5 - var + 48;
                } else {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 2 - var + 48;
                }
            } else if (i >= 9 && i < 13) {
                if (i % 2 == 0) {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 4 - var + 48;
                } else {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 6 - var + 48;
                }
            } else {
                if (i % 2 == 0) {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 3 - var + 48;
                } else {
                    addVar = judgeBackVar(j);
                    j = j - addVar - 7 - var + 48;
                }
            }
            ac[i] = (char) j;
        }
        return String.valueOf(ac);
    }

    /* 编码时间 */
    public String encodeDate(Date d, int var) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date date = new Date();
        String dateTime = String.valueOf(date.getTime());
        String dateString = dateTime.substring(dateTime.length() - 10 - 1, dateTime.length());
        String str = dateString.substring(3, 8) + sdf.format(d) + dateString.substring(0, 3) + dateString.subSequence(8, 10);

        byte abyte0[] = str.getBytes();
        char ac[] = new char[str.length()];

        int addVar = 48;
        for (int i = 0; i < abyte0.length; i++) {
            int j = abyte0[i];
            if (i < 4) {
                if (i % 2 == 0) {
                    addVar = judgeAddVar(j, 1 + var);
                    j = (j - 48) + 1 + var + addVar;
                } else {
                    addVar = judgeAddVar(j, 3 + var);
                    j = (j - 48) + 3 + var + addVar;
                }
            } else if (i >= 4 && i < 9) {
                if (i % 3 == 0) {
                    addVar = judgeAddVar(j, 5 + var);
                    j = (j - 48) + 5 + var + addVar;
                } else {
                    addVar = judgeAddVar(j, 2 + var);
                    j = (j - 48) + 2 + var + addVar;
                }
            } else if (i >= 9 && i < 13) {
                if (i % 2 == 0) {
                    addVar = judgeAddVar(j, 4 + var);
                    j = (j - 48) + 4 + var + addVar;
                } else {
                    addVar = judgeAddVar(j, 6 + var);
                    j = (j - 48) + 6 + var + addVar;
                }
            } else {
                if (i % 2 == 0) {
                    addVar = judgeAddVar(j, 3 + var);
                    j = (j - 48) + 3 + var + addVar;
                } else {
                    addVar = judgeAddVar(j, 7 + var);
                    j = (j - 48) + 7 + var + addVar;
                }
            }
            ac[i] = (char) j;
        }
        return String.valueOf(ac);
    }

    /* 编码时间 */
    public String encodeMacAddr(String macAddr) {
        String str = macAddr.toUpperCase();
        byte abyte0[] = str.toUpperCase().getBytes();
        char ac[] = new char[str.length()];

        for (int i = 0; i < abyte0.length; i++) {
            int j = abyte0[i];
            if (i < 3) {
                if (i % 2 == 0) {
                    j = judgeAddVarMac(j, 1);
                } else {
                    j = judgeAddVarMac(j, 3);
                }
            } else if (i >= 3 && i < 7) {
                if (i % 2 == 0) {
                    j = judgeAddVarMac(j, 5);
                } else {
                    j = judgeAddVarMac(j, 2);
                }
            } else if (i >= 7 && i < 9) {
                if (i % 2 == 0) {
                    j = judgeAddVarMac(j, 4);
                } else {
                    j = judgeAddVarMac(j, 6);
                }
            } else {
                if (i % 2 == 0) {
                    j = judgeAddVarMac(j, 3);
                } else {
                    j = judgeAddVarMac(j, 7);
                }
            }
            ac[i] = (char) j;
        }
        return String.valueOf(ac);
    }
    
    private int judgeAddVar(int nowChar, int add) {
        if (((nowChar - 48) + add) > 9) {
            return 65;
        }
        return 48;
    }
    
    private int judgeAddVarMac(int nowChar, int add){
        int result = 0;
        if(nowChar<58){
            if((nowChar+add) > 57 ){
                result = (nowChar+add) % 10 + add + 65;
            }else{
                result = nowChar + add;
            }
        }else{
            if((nowChar+add) > 70 ){
                result = (nowChar+add) - 70 + 47;
            }else{
                result = nowChar + add;
            }
        }
        return result;
    }

    private int judgeBackVar(int nowChar) {
        if (nowChar >= 65) {
            return 65;
        }
        return 48;
    }

    public String getMacAddress() throws Exception {
        String address = "";
        String os = this.getOSName();

        if (os.startsWith("windows")) {
            address = getWin7MacAddress();
        } else if (os.startsWith("linux")) {
            address = getLinuxMacAddress();
        } else if (os.startsWith("unix")){
            address = getUnixMacAddress();
        } else {
            address = getWindowsMacAddress();
        }
        return address;
    }

    /**
     * 获取当前操作系统名称. return 操作系统名称 例如:windows xp,linux 等.
     */
    public String getOSName() {
        return System.getProperty("os.name").toLowerCase();
    }

    /**
     * 获取unix网卡的mac地址. 非windows的系统默认调用本方法获取. 如果有特殊系统请继续扩充新的取mac地址方法.
     * @return mac地址
     */
    public String getUnixMacAddress() {
        String mac = null;
        BufferedReader bufferedReader = null;
        Process process = null;
        try {
            // linux下的命令，一般取eth0作为本地主网卡
            process = Runtime.getRuntime().exec("ifconfig eth0");
            // 显示信息中包含有mac地址信息
            bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line = null;
            int index = -1;
            while ((line = bufferedReader.readLine()) != null) {
                // 寻找标示字符串[hwaddr]
                index = line.toLowerCase().indexOf("hwaddr");
                if (index >= 0) {// 找到了
                    // 取出mac地址并去除2边空格
                    mac = line.substring(index + "hwaddr".length() + 1).trim();
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (bufferedReader != null) {
                    bufferedReader.close();
                }
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            bufferedReader = null;
            process = null;
        }
        return mac.replace(":", "");
    }

    /**
     * 获取widnows网卡的mac地址.
     * @return mac地址
     */
    public String getWindowsMacAddress() {
        String mac = null;
        BufferedReader bufferedReader = null;
        Process process = null;
        try {
            // windows下的命令，显示信息中包含有mac地址信息
            process = Runtime.getRuntime().exec("ipconfig /all");
            bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line = null;
            int index = -1;
            while ((line = bufferedReader.readLine()) != null) {
                System.out.println(line);
                // 寻找标示字符串[physical
                index = line.toLowerCase().indexOf("physical address");

                if (index >= 0) {// 找到了
                    index = line.indexOf(":");// 寻找":"的位置
                    if (index >= 0) {
                        System.out.println(mac);
                        // 取出mac地址并去除2边空格
                        mac = line.substring(index + 1).trim();
                    }
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (bufferedReader != null) {
                    bufferedReader.close();
                }
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            bufferedReader = null;
            process = null;
        }

        return mac.replace("-", "");
    }

    /**
     * 获取Linux网卡的mac地址.
     * @return mac地址
     */
    public String getLinuxMacAddress() {
        String mac = null;
        BufferedReader bufferedReader = null;
        Process process = null;
        try {
            /**
             * linux下的命令，一般取eth0作为本地主网卡 显示信息中包含有mac地址信息
             */
            process = Runtime.getRuntime().exec("ifconfig eth0");
            bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line = null;
            int index = -1;
            while ((line = bufferedReader.readLine()) != null) {
                index = line.toLowerCase().indexOf("hwaddr");
                /**
                 * 找到了
                 */
                if (index != -1) {
                    /**
                     * 取出mac地址并去除2边空格
                     */
                    mac = line.substring(index + 4).trim();
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (bufferedReader != null) {
                    bufferedReader.close();
                }
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            bufferedReader = null;
            process = null;
        }

        return mac.replace(":", "");
    }

    /**
     * windows 7 专用 获取MAC地址
     * @return
     * @throws Exception
     */
    public String getWin7MacAddress() throws Exception {
        // 获取本地IP对象
        InetAddress ia = InetAddress.getLocalHost();
        // 获得网络接口对象（即网卡），并得到mac地址，mac地址存在于一个byte数组中。
        byte[] mac = NetworkInterface.getByInetAddress(ia).getHardwareAddress();
        // 下面代码是把mac地址拼装成String
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < mac.length; i++) {
            if (i != 0) {
                sb.append("-");
            }
            // mac[i] & 0xFF 是为了把byte转化为正整数
            String s = Integer.toHexString(mac[i] & 0xFF);
            sb.append(s.length() == 1 ? 0 + s : s);
        }
        // 把字符串所有小写字母改为大写成为正规的mac地址并返回
        return sb.toString().replace("-", "");
    }
    
    public void main(String[] args){
        LicenseUtil instance = new LicenseUtil();
        try{
            System.out.println(instance.getMacAddress());
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
