package com.siping.process.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.activiti.engine.repository.Model;

import com.siping.doc.bean.MasterData;

public class ProcessModel extends MasterData {
    private Model model;
    private String editorSource;
    private String processKey;

    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }

    public String getEditorSource() {
        return editorSource;
    }

    public void setEditorSource(String editorSource) {
        this.editorSource = editorSource;
    }

    public String getProcessKey() {
        return processKey;
    }

    public void setProcessKey(String processKey) {
        this.processKey = processKey;
    }

    public String createProcessName() {
        String modename = model.getName();
        SimpleDateFormat formatter = new SimpleDateFormat("_yyyyMMdd_HH:mm");
        String processName = modename + formatter.format(new Date()) + ".bpmn20.xml";
        return processName;
    }

    public String generateProcessId() throws Exception {
        if (model != null && model.getId() != null) {
            return "BusinesProcess-" + model.getId();
        } else {
            return "BusinesProcess";
        }
    }
}
