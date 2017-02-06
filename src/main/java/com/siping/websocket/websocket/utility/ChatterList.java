package com.siping.websocket.websocket.utility;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

public class ChatterList {

    private static List<LinkedHashMap> chatterEmpAndDept = new ArrayList<LinkedHashMap>();

    public void add(LinkedHashMap map) {
        chatterEmpAndDept.add(map);
    }
}
