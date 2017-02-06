package com.siping.web.utility;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.DeserializationContext;
import org.codehaus.jackson.map.JsonDeserializer;

public class BeanDateDeserializer extends JsonDeserializer<Date> {
    private static SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    public Date deserialize(JsonParser arg0, DeserializationContext arg1) throws IOException, JsonProcessingException {
        String dateStr = arg0.getText();
        Date resultDate = null;
        try {
            resultDate = formatter.parse(dateStr);;
        } catch (Exception e) {
        }
        return resultDate;
    }

}
